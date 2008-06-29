;;; yagtd site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(autoload 'yagtd-mode "yagtd-mode" "yaGTD mode" t)
(add-to-list 'auto-mode-alist '("\\.yagtd$" . yagtd-mode))
