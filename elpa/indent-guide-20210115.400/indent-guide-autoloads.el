;;; indent-guide-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "indent-guide" "indent-guide.el" (0 0 0 0))
;;; Generated autoloads from indent-guide.el

(autoload 'indent-guide-mode "indent-guide" "\
show vertical lines to guide indentation

This is a minor mode.  If called interactively, toggle the
`Indent-Guide mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `indent-guide-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(put 'indent-guide-global-mode 'globalized-minor-mode t)

(defvar indent-guide-global-mode nil "\
Non-nil if Indent-Guide-Global mode is enabled.
See the `indent-guide-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `indent-guide-global-mode'.")

(custom-autoload 'indent-guide-global-mode "indent-guide" nil)

(autoload 'indent-guide-global-mode "indent-guide" "\
Toggle Indent-Guide mode in all buffers.
With prefix ARG, enable Indent-Guide-Global mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Indent-Guide mode is enabled in all buffers where `(lambda nil (unless
\(cl-some 'derived-mode-p indent-guide-inhibit-modes)
\(indent-guide-mode 1)))' would do it.

See `indent-guide-mode' for more information on Indent-Guide mode.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "indent-guide" '("indent-guide-"))

;;;***

;;;### (autoloads nil nil ("indent-guide-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; indent-guide-autoloads.el ends here
