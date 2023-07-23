;;; -*- lexical-binding: t -*-
;;; init.el --- This is where all emacs start.

(setq gc-cons-threshold 100000000) 
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 10 1024 1024))))

(setq inhibit-startup-message t)

(prefer-coding-system 'utf-8)

(when (memq window-system '(mac ns x))
  (setq exec-path-from-shell-arguments nil)
  (exec-path-from-shell-initialize))

(setq load-prefer-newer t)
(package-initialize)
(setq package-archives (append
			package-archives
			'(("melpa" . "https://melpa.org/packages/")
                          ("elpa" . "https://elpa.nongnu.org/nongnu/"))))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

;;  (eval-when-compile
    (require 'use-package)
    (require 'quelpa-use-package);)
  (setq use-package-always-ensure t)
  (require 'bind-key)

(use-package async
  :config (setq async-bytecomp-package-mode 1))

(setq default-frame-alist '((ns-transparent-titlebar . t)
                            (height . 48) (width . 159)))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(fringe-mode 16)

(blink-cursor-mode nil)
(setq-default cursor-type 'hbar)

(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(use-package minions
  :config (minions-mode 1))

(use-package diminish)

(setq tab-bar-mode t)
(setq tab-bar-show nil)
(setq frame-title-format '((:eval (format "%s" (cdr (assoc 'name (tab-bar--current-tab)))))))

(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them"
  (mapc #'disable-theme custom-enabled-themes))

(use-package modus-themes
  :init
  (setq modus-themes-bold-constructs t
        modus-themes-completions '((matches . (extrabold intense background))
                                   (selection . (semibold accented intense)))
        modus-themes-org-blocks 'gray-background)
  (setq modus-themes-common-palette-overrides
        '((border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)
          (fringe unspecified)
          (underline-link border)
          (underline-link-visited border)
          (underline-link-symbolic border)
          (bg-region bg-ochre)
          (fg-region unspecified)))
  (setq modus-themes-headings
      '((t . (1.1))))
  :config
  (load-theme 'modus-operandi-tinted :no-confirm))

(set-face-attribute 'default nil :family "Input Mono Compressed" :height 120)

(setq-default fill-column 90)

(use-package fontawesome)
(use-package all-the-icons)

(use-package ivy
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-display-style 'fancy
        ivy-re-builders-alist '((ivy-bibtex . ivy--regex-ignore-order)
                                (t . ivy--regex-plus)))
  :bind (("C-s" . 'swiper-isearch)
         ("C-r" . 'swiper-backward)))

(use-package counsel
  :init (counsel-mode t)
  :bind (("C-x C-r" . 'counsel-recentf)
         ("C-c i" . 'counsel-imenu)
         ("C-c c" . 'counsel-org-capture)
         ("C-x b" . 'ivy-switch-buffer))
  :config
  (setq counsel-grep-base-command "grep -niE %s %s")
  (setq counsel-grep-base-command
        ;; "ag --nocolor --nogroup %s %s")
        "rg -S -M 120 --no-heading --line-number --color never %s %s")
  (setq counsel-find-file-occur-cmd
        "gls -a | grep -i -E '%s' | gxargs -d '\\n' gls -d --group-directories-first")
  (setq counsel-locate-cmd 'counsel-locate-cmd-mdfind))

(use-package prescient
  :config
  (prescient-persist-mode))

(use-package ivy-prescient
  :config (ivy-prescient-mode))

(use-package ivy-hydra)

(use-package which-key
  :diminish
  :init
  (progn
    (setq which-key-idle-delay 1.0)
    (which-key-mode)))

(setq-default indent-tabs-mode nil
              tab-always-indent 'complete
              tab-width 4)

(setq-default initial-major-mode 'text-mode
              default-major-mode 'text-mode)

(setq sentence-end-double-space nil)

(show-paren-mode t)

(pixel-scroll-precision-mode)

(add-hook 'text-mode-hook #'auto-fill-mode)

(global-auto-revert-mode t)

(setq large-file-warning-threshold 100000000)

(use-package avy
  :bind (("M-j" . 'avy-goto-char-timer)
         ("M-\\" . 'avy-goto-line)))

(use-package ace-window
  :config
  (set-face-attribute
   'aw-leading-char-face nil
   :weight 'bold
   :height 2.0)  
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind (("M-o" . 'ace-window)))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("M-<down-mouse-1>" . mc/add-cursor-on-click)
         ("C-c m" . vr/mc-mark)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package electric
  :ensure nil
  :config (electric-pair-mode 1))

(use-package move-text
  :config (move-text-default-bindings))

(use-package hl-line
  :ensure nil
  :custom-face (hl-line ((t (:extend t))))
  :hook (after-init . global-hl-line-mode))

(use-package olivetti
  :config (setq olivetti-style 'fancy))

(use-package csv-mode
  :defer t)

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)))

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(setq insert-directory-program "gls" dired-use-ls-dired t)
(setq dired-recursive-deletes 'always)

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries
   '(("h" "~/"                          "Home")
     ("d" "~/.emacs.d/"                 "Emacs")
     ("p" "~/projects"                  "Projects")
     ("t" "~/.local/share/Trash/files/" "TrashCan")))
  (dirvish-mode-line-format
   '(:left (sort file-time " " file-size symlink) :right (omit yank index)))
  ;; Don't worry, Dirvish is still performant even you enable all these attributes
  (dirvish-attributes '(all-the-icons collapse subtree-state vc-state git-msg))
  :config
  (setq dired-dwim-target t)
  (setq dirvish-mode-line-height 24)
  (setq dirvish-header-line-height 24)
  (setq delete-by-moving-to-trash t)
  ;; Enable mouse drag-and-drop files to other applications
  (setq dired-mouse-drag-files t)                   ; added in Emacs 29
  (setq mouse-drag-and-drop-region-cross-program t) ; added in Emacs 29
  (setq dired-listing-switches
        "-l --almost-all --human-readable --time-style=long-iso --group-directories-first --no-group")
  :bind
  ;; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   ;; Dirvish has all the keybindings in `dired-mode-map' already
   :map dirvish-mode-map
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))

(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions t)
(setq version-control t)
(setq create-lockfiles nil)

(use-package recentf
  :config
  (setq recentf-exclude '("COMMIT_MSG" "COMMIT_EDITMSG" "github.*txt$"
                          "[0-9a-f]\\{32\\}-[0-9a-f]\\{32\\}\\.org"
                          ".*png$" ".*cache$"))
  (setq recentf-max-saved-items 500))

(save-place-mode 1)

(use-package tramp
  :ensure nil
  :defer t
  :config
  (setq tramp-default-user "folgertk"
        tramp-default-method "ssh")
  (use-package counsel-tramp
    :bind ("C-c t" . counsel-tramp))
  (put 'temporary-file-directory 'standard-value '("/tmp")))

(use-package projectile
  :diminish
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action #'projectile-dired)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :init (projectile-mode +1))

(defun projectile-name-tab-by-project-name-or-default ()
  (let ((project-name (projectile-project-name)))
    (if (string= "-" project-name)
        (tab-bar-tab-name-current)
      project-name)))

(setq tab-bar-tab-name-function #'projectile-name-tab-by-project-name-or-default)

(defun counsel-projectile-switch-project-action-dired-new-tab (project)
  (let* ((project-name (file-name-nondirectory (directory-file-name project)))
         (tab-bar-index (tab-bar--tab-index-by-name project-name)))
    (if tab-bar-index
        (tab-bar-select-tab (+ tab-bar-index 1))
      (progn
        (tab-bar-new-tab)
        (let ((projectile-switch-project-action 'projectile-dired))
          (counsel-projectile-switch-project-by-name project))
        (dirvish-side)))))

(defun projectile-kill-buffers-and-enclosing-tab ()
  (interactive)
  (let* ((project-name (projectile-project-name))
         (tab-bar-index (tab-bar--tab-index-by-name project-name)))
    (when tab-bar-index
      (projectile-kill-buffers)
      (tab-bar-switch-to-recent-tab)
      (tab-bar-close-tab (+ tab-bar-index 1)))))

(use-package counsel-projectile
  :after projectile
  :init (counsel-projectile-mode)
  :config
  ;; I want projectile to open dired upon selecting a project. 
  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((add ("T" counsel-projectile-switch-project-action-dired-new-tab "open in new tab") 1)))
  :bind (:map projectile-mode-map
              ("C-c p k" . projectile-kill-buffers-and-enclosing-tab)))

(use-package magit
  :config
  (setq magit-git-executable "/usr/bin/git")
  :bind (("C-x g" . magit-status)
         ("C-c M-g" . magit-file-popup)))

(use-package gitignore-templates
  :defer t)

(use-package org :ensure org-contrib)

(defvar my-agenda-files '("inbox.org" "projects.org" "habits.org" "agenda.org" "leeslijst.org"))
(setq org-directory "~/org"
      org-agenda-files (mapcar
                        (lambda (f) (concat (file-name-as-directory org-directory) f))
                        my-agenda-files)
      org-default-notes-file (concat (file-name-as-directory org-directory) "notes.org"))

(mapc (lambda (item)
        (setf (alist-get item ivy-initial-inputs-alist) ""))
      '(org-refile org-agenda-refile org-capture-refile))

(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm
      org-refile-targets '((org-agenda-files :maxlevel . 2))
      org-refile-targets '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")))

(setq org-todo-keywords '((sequence "TODO" "WAITING" "|" "DONE" "CANCELLED"))
      org-enforce-todo-dependencies t)

(setq org-log-done 'time  ; when marking a todo as done, at the time
      org-log-into-drawer t)  ; log into drawers right underneath the heading

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
         "* TODO %^{Todo} %^G \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
         :empty-lines 1)
        ("m" "Meeting" entry (file+headline "~/org/agenda.org" "Toekomstig")
         "* %^{Description} :meeting:\n%^t"
         :empty-lines 1)
        ("r" "Read" entry (file+headline "~/org/leeslijst.org" "Articles")
         "* TODO %c \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
         :empty-lines 1)
        ("n" "Note" entry (file+headline "~/org/inbox.org" "Notes")
         "* %^{Title} %^G \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
         :empty-lines 1)))

(add-to-list 'load-path (expand-file-name "org-mac-link" "~/.emacs.d/gitrepos"))
(require 'org-mac-link)
(add-hook 'org-mode-hook (lambda ()
(define-key org-mode-map (kbd "C-c g") 'org-mac-link-get-link)))

(org-add-link-type "message" 'org-mac-message-open)

(defun org-mac-message-open (message-id)
  "Visit the message with MESSAGE-ID.
   This will use the command `open' with the message URL."
  (browse-url (concat "message://%3c" (substring message-id 2) "%3e")))

(setq org-capture-template
      (append org-capture-templates
              '(("e" "Mail" entry (file+headline "~/org/inbox.org" "Mail")
                 "* TODO  %(org-mac-message-get-links \"s\") %^g \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
                 :empty-lines 1))))

(setq org-capture-template
      (append org-capture-templates
              '(("l" "Link" entry (file+headline "~/org/bookmarks.org" "Bookmarks")
                 "* %(org-cliplink-capture) %^g \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?"
                 :empty-lines 1))))

(use-package org-cliplink
  :defer t
  :after org)

(use-package org-super-agenda
  :after org
  :config
  (use-package origami
    :bind (:map org-super-agenda-header-map ("<tab>" . origami-toggle-node))
    :hook (org-agenda-mode . origami-mode)))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)

(setq org-agenda-search-view-always-boolean t
      org-agenda-block-separator (propertize
                                  (make-string (frame-width) ?\u2594)
                                  'face '(:foreground "grey38"))
      org-super-agenda-header-separator ""
      org-habit-show-habits-only-for-today nil
      org-agenda-restore-windows-after-quit t
      org-agenda-show-future-repeats nil
      org-deadline-warning-days 2
      org-agenda-window-setup 'current
      org-agenda-span 'day
      org-agenda-start-on-weekday 1 ;; nil
      org-agenda-skip-deadline-prewarning-if-scheduled t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-format-date "\n%A, %-e %B %Y"
      org-agenda-dim-blocked-tasks t)

(setq org-agenda-custom-commands
      '(("d" "Dagelijkse Takenlijst"
         ((agenda ""
                  ((org-agenda-overriding-header " Planner")
                   (org-agenda-prefix-format '((agenda . " %?-12t")))
                   (org-agenda-span 'day)
                   (org-deadline-warning-days 0)
                   (org-super-agenda-groups
                    '((:name "" :time-grid t :scheduled t :deadline t :category "verjaardag")
                      (:discard (:anything t))))))))))

(org-super-agenda--def-auto-group category "their org-category property"
  :key-form (org-super-agenda--when-with-marker-buffer (org-super-agenda--get-marker item)
              (org-get-category))
  :header-form (concat " " key))

(setq org-agenda-custom-commands (append org-agenda-custom-commands
        '(("p" "Project backlog"
          ((todo "TODO|NEXT|WAITING|HOLD"
                ((org-agenda-overriding-header " Inbox\n")
                 (org-agenda-prefix-format "  ")
                 (org-agenda-files '("~/org/inbox.org"))))
          (todo "TODO|NEXT|WAITING|HOLD"
                 ((org-agenda-overriding-header " Project TODOs")
                 (org-agenda-prefix-format "  ")
                  (org-agenda-files '("~/org/projects.org"))
                  (org-super-agenda-groups
                   '((:discard (:scheduled t :date t))
                     (:auto-category t)
                     (:discard (:anything t))))))
          (todo "TODO|NEXT"
                ((org-agenda-overriding-header " Reading List")
                 (org-agenda-prefix-format "  ")
                 (org-agenda-files '("~/org/leeslijst.org"))
                 (org-super-agenda-groups
                  '((:discard (:scheduled t))
                    (:name " Priority A reading" :priority "A")
                    (:name " Priority B reading" :priority "B")
                    (:name " Priority C reading" :priority "C")
                     (:discard (:anything t)))))))))))

(defun format-closed-query ()
  (format "+TODO=\"DONE\"+CLOSED>=\"<-%sd>\"" (read-string "Number of days: ")))
(setq org-agenda-custom-commands (append org-agenda-custom-commands
        '(("w" "Weekly review"
         ((tags (format-closed-query)
                ((org-agenda-overriding-header "Overview of DONE tasks")
                 (org-agenda-archives-mode t))))))))

;; Functions to keep calendar in sight when working on the agenda
(defun fk-window-displaying-agenda-p (window)
  (equal (with-current-buffer (window-buffer window) major-mode)
         'org-agenda-mode)) 

(defun fk-position-calendar-buffer (buffer alist)
  (let ((agenda-window (car (remove-if-not #'fk-window-displaying-agenda-p (window-list)))))
    (when agenda-window
      (if (not (get-buffer-window "*Calendar*"))
          (let ((desired-window (split-window agenda-window nil 'below)))
            (set-window-buffer desired-window buffer)
            desired-window)))))

(add-to-list 'display-buffer-alist (cons "\\*Calendar\\*" (cons #'fk-position-calendar-buffer nil)))
(use-package calfw)
(use-package calfw-org)

(defun side-by-side-agenda-view ()
  (progn
    (org-agenda nil "a")
    (split-window-right)
    (org-agenda-redo)
    (split-window-below)
    (other-window 1)
    (cfw:open-org-calendar)
    (setq org-agenda-sticky t)
    (other-window 1)
    (org-agenda nil "p")
    (setq org-agenda-sticky nil)))

(defun show-my-agenda ()
  (interactive)
  (let ((tab-bar-index (tab-bar--tab-index-by-name "Agenda")))
    (if tab-bar-index
        (tab-bar-select-tab (+ tab-bar-index 1))
      (progn
        (tab-bar-new-tab)
        (tab-bar-rename-tab "Agenda")
        (side-by-side-agenda-view)
        (message "Agenda loaded")))))

(use-package org-roam
  :init 
  (setq org-roam-v2-ack t)
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory (file-truename "~/kaartenbak"))
  :bind (("C-c o l" . org-roam-buffer-toggle)
         ("C-c o f" . org-roam-node-find)
         ("C-c o g" . org-roam-graph)
         ("C-c o i" . org-roam-node-insert)
         ("C-c o c" . org-roam-capture)
         ;; Dailies
         ("C-c o j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup)
  (setq org-roam-db-gc-threshold (* 10 1024 1024))
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (require 'org-roam-export) ;; check whether this helps exporting
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :if-new (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n")))))

(use-package org-roam-bibtex
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :after org-roam)

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-browser-function #'browse-url-chromium
        org-roam-ui-open-on-start nil))

(defun open-kaartenbak ()
  (interactive)
  (let ((tab-bar-index (tab-bar--tab-index-by-name "Kaartenbak")))
    (if tab-bar-index
        (tab-bar-switch-to-tab (+ tab-bar-index 1))
      (progn
        (tab-bar-new-tab)
        (tab-bar-rename-tab "Kaartenbak")
        (find-file "~/kaartenbak/20210727213932-kaartenbak.org")))))

(setq org-use-speed-commands t  ; set to true for navigation with shortcuts
      org-image-actual-width (list 550) ; resize the width of images
      org-format-latex-options (plist-put org-format-latex-options :scale 1.5)
      org-src-fontify-natively t  ; use auctex for formatting latex in org
      org-hide-leading-stars nil  ; Show all stars of headers
      org-adapt-indentation nil   ; Don't indent subsections (helps org-babel code blocks)
      org-cite-global-bibliography '("~/org/bib.bib")  ; for citing references
      org-latex-create-formula-image-program 'dvisvgm
      org-latex-default-class "tufte-handout"
      org-highlight-latex-and-related '(native))

(use-package org-download)

(use-package ox-hugo
  :config
  (require 'oc-csl)
  (setq org-hugo-base-dir "~/local/folgertk/")
  (setq org-hugo--preprocess-buffer nil)
  (setq org-hugo-auto-set-lastmod t)
  (setq org-cite-csl-styles-dir "~/Zotero/styles")
  (setq org-cite-export-processors '((t csl)))
  :after ox)

(use-package tex
  :defer t
  :ensure auctex
  :init
  (progn
    (setq TeX-auto-save t
          TeX-parse-self t
          TeX-PDF-mode 1
          ;; Don't insert line-break at inline math
          LaTeX-fill-break-at-separators nil
          TeX-view-program-list
          '(("Preview.app" "open -a Preview.app %o")
            ("Skim" "open -a Skim.app %o")
            ("displayline" "displayline -g -b %n %o %b")
            ("open" "open %o"))
          TeX-view-program-selection
          '((output-dvi "open")
            (output-pdf "Skim")
            (output-html "open")))
    (add-hook 'TeX-mode-hook #'turn-on-reftex))
  :config
  (bind-key "C-c h l" 'hydra-langtool/body TeX-mode-map)
  (company-auctex-init))

(use-package ox-latex
  :ensure nil
  :defer t
  :config
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)

  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (add-to-list 'org-latex-classes
             '("tufte-handout"
               "\\documentclass{tufte-handout}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package bibtex
  :mode (("\\.bib\\'" . bibtex-mode)))

(use-package ivy-bibtex
  :bind*
  ("C-c C-r" . ivy-bibtex)
  :config
  (setq bibtex-completion-bibliography "~/org/bib.bib")
  (setq bibtex-completion-pdf-field "File")
  (setq bibtex-completion-pdf-open-function 'bibtex-pdf-open-function)
  (setq ivy-bibtex-default-action #'ivy-bibtex-insert-citation)
  (setq bibtex-completion-display-formats '((t . "${author:36} ${title:*} ${year:4} ${=type=:7}")))
  (setq bibtex-completion-format-citation-functions
        '((org-mode      . bibtex-completion-format-citation-org-cite)
          (latex-mode    . bibtex-completion-format-citation-cite)
          (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
          (default       . bibtex-completion-format-citation-default)))
  (ivy-bibtex-ivify-action add-to-reading-list ivy-bibtex-add-to-reading-list)
  (ivy-bibtex-ivify-action show-pdf-in-finder ivy-bibtex-show-pdf-in-finder)
  (ivy-bibtex-ivify-action read-on-remarkable ivy-bibtex-read-on-remarkable)
  (ivy-add-actions 'ivy-bibtex '(("R" ivy-bibtex-add-to-reading-list "add to reading list")))
  (ivy-add-actions 'ivy-bibtex '(("F" ivy-bibtex-show-pdf-in-finder "show in finder")))
  (ivy-add-actions 'ivy-bibtex '(("M" ivy-bibtex-read-on-remarkable "read on remarkable"))))

(defun add-to-reading-list (keys &optional fallback-action)
  (let ((link (bibtex-completion-format-citation-org-title-link-to-PDF keys)))
    (kill-new link)
    (org-capture nil "r")))

(defun read-on-remarkable (keys &optional fallback-action)
  (let ((fpath (car (bibtex-completion-find-pdf (car keys)))))
    (call-process "rmapi" nil 0 nil "put" fpath)))

(defun bibtex-pdf-open-function (fpath)
  (call-process "open" nil 0 nil "-a" "/Applications/Skim.app" fpath))

(defun show-pdf-in-finder (keys &optional fallback-action)
  (let ((dir (file-name-directory (car (bibtex-completion-find-pdf (car keys))))))
    (cond
     ((> (length dir) 1)
      (shell-command (concat "open " dir)))
     (t
      (message "No PDF(s) found for this entry: %s" key)))))

(use-package pdf-tools
  :config (setq pdf-view-use-scaling t))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc")
  :config
  (setq visual-line-column 90)
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-enable-math t))

(use-package pandoc-mode
  :after org)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-enable-symbol-highlighting nil
        lsp-lens-enable nil
        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-code-actions-enable nil
        lsp-diagnostics-provider :none
        lsp-modeline-diagnostics-enable nil
        lsp-completion-show-detail nil
        lsp-completion-show-kind nil
        lsp-pyright-python-executable-cmd "python3"
        )
  :commands (lsp lsp-deferred))

(use-package company
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (setq company-global-modes '(not text-mode term-mode markdown-mode gfm-mode))
  (setq company-selection-wrap-around t
        company-show-numbers t
        company-tooltip-align-annotations t
        company-idle-delay 0.5
        company-require-match nil
        company-minimum-prefix-length 2)
  ;; Bind next and previous selection to more intuitive keys
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  ;; (add-to-list 'company-frontends 'company-tng-frontend)
  ;; :bind (("TAB" . 'company-indent-or-complete-common)))
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map ("<tab>" . company-complete-selection))
  (:map lsp-mode-map ("<tab>" . company-indent-or-complete-common)))

(use-package company-prescient
  :config (company-prescient-mode))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package pyvenv
  :init (setenv "WORKON_HOME" "~/.virtualenvs/"))

(use-package jupyter
  :after org
  :defer t
  :config
  (setq org-babel-python-command "python3")
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages 'org-babel-load-languages '((jupyter . t)))
  ;; default args for jupyter-python
  (setq org-babel-default-header-args:jupyter-python
   ;; NOTE: for converting Python Dataframes into org tables, I'm using code from
   ;; https://github.com/gregsexton/ob-ipython/blob/7147455230841744fb5b95dcbe03320313a77124/README.org#tips-and-tricks
   ;; which I put in .ipython/profile_default/startup/orgtable.py as a startup file for ipython. 
        '((:results . "replace")
          (:async . "yes")
          (:session . "py")
          (:kernel . "python3")))
  (setq org-babel-default-header-args:jupyter-R
        '((:results . "replace")
          (:async . "yes")
          (:session . "R")
          (:kernel . "R")))
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images))

(use-package ess
  :defer t
  :config
  (setq ess-eval-visibly 'nowait))

(use-package stan-mode :defer t)

(use-package company-stan
  :after stan-mode
  :hook (stan-mode . company-stan-setup))

(use-package eldoc-stan
  :after stan-mode
  :hook (stan-mode . eldoc-stan-setup))

(use-package deadgrep
  :bind*
  (("C-c r" . deadgrep)))

(use-package terminal-here
  :config
  (setq terminal-here-mac-terminal-command 'iterm2))

(defun comment-current-line-dwim ()
  "Comment or uncomment the current line."
  (interactive)
  (save-excursion
    (if (use-region-p)
        (comment-or-uncomment-region (region-beginning) (region-end))
      (push-mark (beginning-of-line) t t)
      (end-of-line)
      (comment-dwim nil))))

(defun new-scratch-pad ()
"Create a new org-mode buffer for random stuff."
(interactive)
(let ((tab-bar-index (tab-bar--tab-index-by-name "Kladblok")))
  (if tab-bar-index
      (progn
        (tab-bar-select-tab (+ tab-bar-index 1))
        (switch-to-buffer "kladblok")
        (olivetti-mode t))
    (progn
      (tab-bar-new-tab)
      (tab-bar-rename-tab "Kladblok")
      (let ((buffer (generate-new-buffer "kladblok")))
        (switch-to-buffer buffer)
        (setq buffer-offer-save t)
        (org-mode)
        (olivetti-mode t))))))

(defun xah-unfill-paragraph ()
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (fill-paragraph)))

(defhydra hydra-windows (:color red)
  ("s" shrink-window-horizontally "shrink horizontally" :column "Sizing")
  ("e" enlarge-window-horizontally "enlarge horizontally")
  ("b" balance-windows "balance window height")
  ("m" maximize-window "maximize current window")
  ("M" minimize-window "minimize current window")
  
  ("h" split-window-below "split horizontally" :column "Split management")
  ("v" split-window-right "split vertically")
  ("d" delete-window "delete current window")
  ("x" delete-other-windows "delete-other-windows")
  ("q" nil "quit menu" :color blue :column nil))

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(global-set-key (kbd "M-/") 'comment-current-line-dwim)
(global-set-key (kbd "M-+")  'mode-line-other-buffer)
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x K") 'kill-buffer)
(global-set-key (kbd "C-c s") 'new-scratch-pad)
;; Turn off swiping to switch buffers (defined in mac-win.el)
(global-unset-key [swipe-left])
(global-unset-key [swipe-right])
(global-unset-key (kbd "C-<mouse-4>"))
(global-unset-key (kbd "C-<mouse-5>"))
(global-unset-key (kbd "C-<wheel-down>"))
(global-unset-key (kbd "C-<wheel-up>"))
(global-set-key (kbd "M-n") 'hydra-windows/body)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map (kbd "C-c M-a") 'show-my-agenda)
(global-set-key (kbd "C-x C-b") 'tab-bar-select-tab-by-name)

(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

(setq custom-file (expand-file-name "custom.el" "~/.emacs.d"))

(when (file-exists-p custom-file)
  (load custom-file))
