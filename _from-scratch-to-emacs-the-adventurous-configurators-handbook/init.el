;; Config found at https://ruivieira.dev/from-scratch-to-emacs-the-adventurous-configurators-handbook.html

;; Open the init file
(find-file "~/.emacs.d/init.el")

;; create and use a custom.el file for all package and application customisations
(customize-save-variable 'custom-file  (expand-file-name "custom.el" user-emacs-directory))
(load-file custom-file)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(setq evil-want-keybinding nil)

(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 90))

(set-frame-font "Fira Code-10" nil t)

;; Remove the menu bar and tool bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Projectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(require 'projectile)
(projectile-mode +1)

;;; Enable Projectile and configure it to remember recent projects
(projectile-mode +1)
(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-indexing-method 'alien)
(setq projectile-completion-system 'ivy)

;;; Create a function to display recent projects on startup
(defun display-projectile-list-on-startup ()
  (let ((buf (get-buffer-create "*Projectile Projects*")))
    (with-current-buffer buf
      (erase-buffer)
      (dolist (project (projectile-relevant-known-projects))
        (insert project "\n")))
    (switch-to-buffer buf)))

;; Mini-frame
(unless (package-installed-p 'mini-frame)
  (package-install 'mini-frame))

(require 'mini-frame)
(mini-frame-mode 1)

(setq mini-frame-show-parameters
      '((top . 0)
        (width . 0.7)
        (left . 0.5)))

;; Ivy support
(unless (package-installed-p 'ivy)
  (package-install 'ivy))

(unless (package-installed-p 'ivy-posframe)
  (package-install 'ivy-posframe))


(require 'ivy)
(ivy-mode 1)

(require 'ivy-posframe)
(setq ivy-display-function #'ivy-posframe-display-at-frame-center)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
(ivy-posframe-mode 1)

;; Doom modeline
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))

(require 'doom-modeline)
(doom-modeline-mode 1)

;; Markdown
(dolist (package '(markdown-mode markdown-toc markdownfmt))
  (unless (package-installed-p package)
    (package-install package)))

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; Enable font-lock globally (syntax highlighting for code blocks)
(global-font-lock-mode 1)

;; ...

(setq markdown-fontify-code-blocks-natively t)

(setq scroll-conservatively 101)

;; Speed bar
(dolist (package '(which-key general))
  (unless (package-installed-p package)
    (package-install package)))

(require 'which-key)
(which-key-mode)

(require 'general)
(general-create-definer my-leader-def
  :states '(normal visual insert emacs)
  :prefix "M-SPC"
  :non-normal-prefix "M-SPC")

(my-leader-def
  "p"  '(:ignore t :which-key "projects")
  "pf" 'projectile-find-file)
 
(setq which-key-idle-delay 0.5) ;; default 0. 5

;; Font name
(defvar my-font-name "Fira Code")

(set-frame-font (concat my-font-name "-10") nil t)
(set-face-attribute 'fixed-pitch nil :family my-font-name :height 120)

;;; ...

(setq markdown-enable-wiki-links t)

;; Match Markdown font main one
(set-face-attribute 'markdown-code-face nil :family my-font-name)
(set-face-attribute 'markdown-pre-face nil :family my-font-name)

;;; ...

;; Modus operandi
(load-theme 'modus-vivendi-tinted t)

;; Buffer splitting
(defun split-right-and-list-project-files ()
  "Split the current window into two, left and right. The left one contains the current contents and the right one contains a projectile-list of all the files in the project."
  (interactive)
  (split-window-right)
  (other-window 1)
  (projectile-find-file))

(defun split-below-and-list-project-files ()
  "Split the current window into two, top and bottom. The top one contains the current contents and the bottom one contains a projectile-list of all the files in the project."
  (interactive)
  (split-window-below)
  (other-window 1)
  (projectile-find-file))

(my-leader-def
  "b"  '(:ignore t :which-key "Buffers")
  "bs" '(:ignore t :which-key "Split")
  "bsr" '(split-right-and-list-project-files :which-key "Right split")
  "bst" '(split-below-and-list-project-files :which-key "Top split"))

 ;; First, we ensure that the yaml-mode package is installed. If not, Emacs is instructed to download and install it.
 (unless (package-installed-p 'yaml-mode)
  (package-refresh-contents)
  (package-install 'yaml-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

(add-hook 'yaml-mode-hook
  (lambda ()
    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(add-hook 'yaml-mode-hook
  (lambda ()
    (hs-minor-mode 1)))

(add-hook 'yaml-mode-hook 'company-mode)

;; Add YAML lint. Must have `pip install yamllint` installed.
(add-hook 'yaml-mode-hook 'flycheck-mode)

(unless (package-installed-p 'indent-guide)
  (package-install 'indent-guide))

(require 'indent-guide)
(add-hook 'yaml-mode-hook 'indent-guide-mode)
(set-face-foreground 'indent-guide-face "lightgray")
(set-face-background 'indent-guide-face nil)
(setq indent-guide-char ":")

(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

(require 'evil-collection)

(unless (package-installed-p 'magit)
  (package-install 'magit))

(setq my-modes '(rust-mode-hook
                 python-mode-hook
                 go-mode-hook
                 markdown-mode-hook
                 yaml-mode-hook))

(mapc (lambda (mode)
        (add-hook mode (lambda () (add-hook 'after-save-hook 'magit-refresh-status))))
      my-modes)

(setq magit-repo-dirs
      (mapcar
       (lambda (dir)
         (substring dir 0 -1))
       (cl-remove-if-not
        (lambda (project)
          (unless (file-remote-p project)
            (file-directory-p (concat project "/.git/"))))
        (projectile-relevant-known-projects))))

(my-leader-def
 :states '(normal visual emacs)
 :keymaps 'override
 "g"  '(:ignore t :which-key "Git")
 "gs" '(magit-status :which-key "Show status")
 "gb" '(magit-branch :which-key "Show all branches")
;; "gco" '(magit-checkout :which-key "Checkout branch")
 "gr" '(magit-rebase :which-key "Rebase on a branch")
;; "gsq" '(magit-rebase-squash :which-key "Squash commits")
 "gc" '(magit-commit :which-key "Commit")
 "gp" '(magit-push-popup :which-key "Push"))

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd ":") 'evil-ex))

(defun my-magit-setup ()
  (define-key evil-normal-state-local-map (kbd ":") 'evil-ex))

(add-hook 'magit-status-mode-hook 'my-magit-setup)

(defun ignore-mouse (ret)
  (let ((debug-on-message "unbound suffix <mouse movement>"))
    (if (called-interactively-p 'interactive)
        ret
      (ignore-errors (funcall ret)))))

(advice-add 'magit-key-mode-error-message :around 'ignore-mouse)

(unless (package-installed-p 'org)
  (package-install 'org))

(defvar my-org-root-directory "~/notes/org/"
  "Root directory for Org mode files.")

(setq org-directory my-org-root-directory)

(defun my-org-open-index-file ()
  "Open the index file for Org mode."
  (interactive)
  (find-file (expand-file-name "index.org" my-org-root-directory)))

(setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                  (header-line (:height 4.0) variable-pitch)
                                  (org-document-title (:height 1.75) org-document-title)
                                  (org-code (:height 1.55) org-code)
                                  (org-verbatim (:height 1.55) org-verbatim)
                                  (org-block (:height 1.25) org-block)
                                  (org-block-begin-line (:height 0.7) org-block)))

(unless (package-installed-p 'org-modern)
  (package-install 'org-modern))

(add-hook 'org-mode-hook #'org-modern-mode)

(add-hook 'org-mode-hook (lambda () (org-indent-mode)))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t
 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")

(setq org-modern-indent t)

(custom-set-faces
 '(org-document-title ((t (:inherit outline-1 :height 1.5)))))
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.1)))))

(setq org-todo-keywords
      '((sequence "TODO" "LATER" "|" "DONE")))

(global-org-modern-mode)

(setq org-default-notes-file (expand-file-name "inbox.org" my-org-root-directory))
(setq org-capture-templates
      `(("c" "Capture" entry (file+headline org-default-notes-file "LATER")
         "* LATER %?\n\n  %i\n\n  %a")))

(my-leader-def
  :states '(normal visual emacs)
  :keymaps 'override
  "o" '(:ignore t :which-key "Org Mode")
  "oi" '(my-org-open-index-file :which-key "Open Index File")
  "oc" '(org-capture :which-key "Capture"))








