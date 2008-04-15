
;;; emacs-template site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(load "template")
(template-initialize)
