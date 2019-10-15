
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b46ee2c193e350d07529fcd50948ca54ad3b38446dcbd9b28d0378792db5c088" default)))
 '(electric-pair-mode t)
 '(elfeed-feeds (quote ("https://nyaa.si/?page=rss")))
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice "C:\\Users\\thoma\\Dev")
 '(org-agenda-files
   (quote
    ("~/Dev/orgs/Personal.org" "~/Dev/orgs/learnning.org" "c:/Users/thoma/Dev/orgs/QUT.org" "c:/Users/thoma/Dev/orgs/COF.org")))
 '(org-agenda-search-headline-for-time nil)
 '(org-agenda-skip-additional-timestamps-same-entry t)
 '(org-agenda-skip-timestamp-if-deadline-is-shown nil)
 '(org-babel-load-languages (quote ((js . t) (java . t) (python . t) (emacs-lisp . t))))
 '(org-directory "c:/Users/thoma/Dev/orgs/")
 '(org-html-htmlize-output-type (quote css))
 '(org-refile-targets
   (quote
    ((org-agenda-files :regexp . "*")
     (org-agenda-files :maxlevel . 5))))
 '(org-src-tab-acts-natively t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (elfeed exec-path-from-shell indium htmlize auctex yasnippet-snippets jedi neotree powerline dracula-theme evil-magit helm org-evil evil linum-relative org undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "SauceCodePro Nerd Font" :foundry "outline" :slant normal :weight normal :height 100 :width normal)))))

(require 'package)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; disable sound
(setq visible-bell 1)

;; Load emacs packages and activate them
;; This must come before configurations of installed packages.
;; Don't delete this line.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(add-to-list 'load-path "~/.emacs.d/plugins/evil-surround")
(add-to-list 'load-path "~/.emacs.d/plugins/yaml-mode")
(add-to-list 'load-path "~/.emacs.d/elpa/")
;(require 'linum-relative)
;(linum-on); load linum-relative
(global-display-line-numbers-mode t)
(electric-pair-mode t)

(require 'dracula-theme)
(load-theme 'dracula t)
(require 'powerline)
(powerline-center-evil-theme)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;; enable python source code eval
(require 'ob-python)
;; enable javascript source code eval
(require 'ob-js)
;;(add-to-list 'org-babel-load-languages '(js . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
(add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))

;; cater for whitespace sensetive languages
(setq org-edit-src-content-indentation 4)
(setq org-src-fontify-natively t)
;;(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)

;; evil org
(require 'evil)
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
(evil-mode 1)

;; evil surround
(require 'evil-surround)
(add-hook 'org-mode-hook 'turn-on-evil-surround-mode)

;; include entries from the Emacs diary into Org mode's agenda
(setq org-agenda-include-diary t)
;; turn on indent mode in Org
(add-hook 'org-mode-hook 'org-indent-mode)
;; (add-hook 'org-mode-hook 'linum-relative-mode)

;; yaml support
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
;; set effort estimates
(setq org-global-properties (quote (("Effort_ALL" . "0:05 0:10 0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

;; capture
(setq org-default-notes-file (concat org-directory "/quick_notes.org"))

;; wrap lines
(global-visual-line-mode 1)

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)    ;optional

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

; js2 minor mode
(add-hook 'js-mode-hook 'js2-minor-mode)
