;; org directory
(setq org-directory "~/Documents/Emacs/org")

;; mobile-org directory
(setq org-mobile-directory (expand-file-name "~/Dropbox/Apps/MobileOrg"))

;; 12 hours format
(setq org-timestamp-12-hours nil)

;; hide all non scheduled items from agenda view
(setq org-hide-all-non-scheduled-items t)

;; don's source the tags/context from the context.txt file
(setq org-disable-context-file t)

;; practical.org.el GTD+Zettelkasten workflow
(setq practical-org-mode-el
      (expand-file-name "~/.emacs.d/pkgs/practical.org.el/practical.org.el"))
(load-file practical-org-mode-el)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(bbdb yaml-mode which-key terminal-here quelpa-use-package pyvenv pdf-tools pandoc-mode ox-hugo origami org-super-agenda org-roam-ui org-roam-bibtex org-modern org-download org-contrib org-cliplink olivetti multiple-cursors move-text moody modus-themes minions mini-frame markdownfmt markdown-toc magit lsp-pyright jupyter ivy-prescient ivy-posframe ivy-hydra ivy-bibtex indent-guide gitignore-templates general fontawesome expand-region evil-collection ess eldoc-stan doom-modeline dirvish diminish deadgrep csv-mode counsel-tramp counsel-projectile company-stan company-prescient calfw-org calfw all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
