#!/usr/bin/env perl

use strict;
use warnings;
use version;
use Tie::File;

my $overlaypkglist = "PACKAGES-DESCRIPTIONS";
open my $ofh, ">".$overlaypkglist
  or die "Error: Couldn't open $overlaypkglist: $!\n";


print $ofh <<HEADER;
PACKAGES AND DESCRIPTIONS:

HEADER

my $overlay = "/usr/local/ephemeral-gentoo-overlay";

my $cref = &getcategories($overlay);
foreach my $category (@$cref) {
  my $catdir = "$overlay/$category";
  my $pref = &getpackages($catdir);
  foreach my $pkg (@$pref) {
    my $pkgdir = "$catdir/$pkg";
    my ($nmeref,$verref,$ebdref) = &getnamesvers($pkgdir);
    my ($idx,$name,$version,$latest) = &findlatestversion($pkgdir);
    my ($desc,$url) = &getpkgdetails("$pkgdir/$latest");
    $latest =~ s/\.ebuild//;
#    print $ofh qq($category/$$nmeref[$idx] [v$$verref[$idx]]:\n\t$desc\n\turl: $url\n);
    print $ofh qq($category/$$nmeref[$idx]:\n\t$desc\n\turl: $url\n);
  }
}

my $current_date = `date -u '+%H:%M %Y-%m-%d'`; chomp $current_date;
# print $ofh <<FOOTER;

# NOTES:
# - "9999" versions indicate live ebuilds, you might like to install
# the "update-live-ebuilds" utility described in:
#     http://forums.gentoo.org/viewtopic-t-518701.html"
# to make the most use out of them.
# FOOTER

close $ofh;
exit 0;

sub getcategories {
  my $dir = shift;
  opendir DIR, $dir || die "Error: Couldn't open $dir: $!";
  my @categories = grep { /\w+-\w+/ && -d "$dir/$_" } readdir(DIR);
  closedir DIR;
  return \@categories;
}

sub getpackages {
  my $dir = shift;
  opendir DIR, $dir || die "Error: Couldn't open $dir: $!";
  my @packages = grep { !/^\./ && -d "$dir/$_" } readdir(DIR);
  closedir DIR;
  return \@packages;
}

sub getnamesvers {
  my $dir = shift;
  opendir my $ebdir, $dir || die "Error: Couldn't open $dir: $!";
  my @ebuilds = grep { /ebuild$/ } readdir $ebdir;
  closedir $ebdir;
  my (@versions,@names);
  foreach my $ebuild (@ebuilds) {
    $ebuild =~ /(\S+)-(\d+.*).ebuild/;
    push @names, $1;
    push @versions, $2;
  }
  return \@names, \@versions, \@ebuilds;
}

  

sub findlatestversion {
  my $dir = shift;
  my ($latest,$latest_name,$latest_version);
  my ($names_ref, $versions_ref, $ebuilds_ref) = &getnamesvers($dir);
  my (@versions,@raw_versions);
  foreach my $ebuild (@$ebuilds_ref) {
    $ebuild =~ /(\S+)-(\d+.*).ebuild/;
    my $nme = $1;
    my $ver = $2;
    push @raw_versions, $2;
    $ver =~ s/(_rc|_beta)//; # strip plain beta/rc
    $ver =~ s/(_rc|_beta)(\d+)?/\.$2/; # replace numbered beta/rc
    $ver =~ s/-r(\d+)/\.$1/; # replace revision candidate
    $ver =~ s/[[:alpha:]]//; # strip any remaning letters
    push @versions, version->new($ver);
  }
  my $maxver = version->new(0);
  my $maxveridx = 0;
  for(my $v = 0; $v <= $#versions; $v++) {
    if($versions[$v] > $maxver) {
      $maxver = $versions[$v];
      $maxveridx = $v;
      $latest = $$ebuilds_ref[$v];
      $latest_version = $raw_versions[$v];
      $latest_name = $latest;   $latest_name =~ s/-"$versions[$v]"\.ebuild//;
    }
  }
  return $maxveridx, $latest_name, $latest_version, $latest;
}

sub getpkgdetails {
  my $ebuild = shift;
  tie my @contents, 'Tie::File', $ebuild 
    or die "Error: Couldn't open $ebuild: $!\n";
  my ($url,$desc);
  foreach my $line (@contents) {
    if($line =~ /^DESCRIPTION/) {
      $line =~ /"(.*)"/;
      $desc = $1;
    }
    if($line =~ /^HOMEPAGE/) {
      $line =~ /"(.*)"/;
      $url = $1;
    }      
  }
  untie @contents;
  return $desc, $url;
}
