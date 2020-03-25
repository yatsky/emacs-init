
(require 'package)

(setq package-enable-at-startup nil)

(setq package-archives
      (quote
       (("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/"))))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b46ee2c193e350d07529fcd50948ca54ad3b38446dcbd9b28d0378792db5c088" default)))
 '(debug-on-error t)
 '(ein:completion-backend (quote ein:use-none-backend))
 '(ein:polymode t)
 '(elfeed-feeds (quote ("https://nyaa.si/?page=rss")))
 '(global-display-line-numbers-mode t)
 '(helm-completion-style (quote emacs))
 '(load-prefer-newer t)
 '(org-agenda-search-headline-for-time nil)
 '(org-agenda-skip-additional-timestamps-same-entry t)
 '(org-agenda-skip-timestamp-if-deadline-is-shown nil)
 '(org-babel-load-languages
   (quote
    ((js . t)
     (java . t)
     (python . t)
     (emacs-lisp . t)
     (ein . t)
     (ditaa . t))))
 '(org-confirm-babel-evaluate nil)
 '(org-drill-learn-fraction 0.45)
 '(org-drill-maximum-items-per-session 80)
 '(org-export-use-babel nil)
 '(org-html-htmlize-output-type (quote css))
 '(org-html-preamble-format (quote (("en" "<p>%t</p></p>%d</p>"))))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-eww org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill)))
 '(org-refile-targets
   (quote
    ((org-agenda-files :regexp . "*")
     (org-agenda-files :maxlevel . 5))))
 '(org-screenshot-image-directory "/tmp/images/")
 '(org-src-tab-acts-natively t)
 '(package-check-signature nil)
 '(package-selected-packages
   (quote
    (blacken command-log-mode org-tree-slide emojify pyim-wbdict all-the-icons use-package helm-core virtualenvwrapper projectile pdf-tools posframe pyim json-mode elisp-format general gif-screencast which-key org-mime evil-collection flycheck tide web-mode rjsx-mode org-bullets magit org-brain org-plus-contrib el-get gnu-elpa-keyring-update jedi-core cnfonts ein request-deferred elfeed exec-path-from-shell indium htmlize auctex yasnippet-snippets jedi powerline dracula-theme evil-magit helm org-evil evil org undo-tree)))
 '(pdf-view-midnight-colors (quote ("white smoke" . "black"))))


(org-babel-load-file (expand-file-name "~/.emacs.d/yaoni.org"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
