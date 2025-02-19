;;; bibtex-completion-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "bibtex-completion" "bibtex-completion.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from bibtex-completion.el
 (put 'bibtex-completion-bibliography 'safe-local-variable 'stringp)

(put 'bibtex-completion-notes-global-mode 'globalized-minor-mode t)

(defvar bibtex-completion-notes-global-mode nil "\
Non-nil if Bibtex-Completion-Notes-Global mode is enabled.
See the `bibtex-completion-notes-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `bibtex-completion-notes-global-mode'.")

(custom-autoload 'bibtex-completion-notes-global-mode "bibtex-completion" nil)

(autoload 'bibtex-completion-notes-global-mode "bibtex-completion" "\
Toggle Bibtex-Completion-Notes mode in all buffers.
With prefix ARG, enable Bibtex-Completion-Notes-Global mode if ARG is positive; otherwise,
disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Bibtex-Completion-Notes mode is enabled in all buffers where
`bibtex-completion-notes-mode' would do it.

See `bibtex-completion-notes-mode' for more information on Bibtex-Completion-Notes mode.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "bibtex-completion" '("bibtex-completion-"))

;;;***

;;;### (autoloads nil nil ("bibtex-completion-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; bibtex-completion-autoloads.el ends here
