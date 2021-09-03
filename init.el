
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
   '("691421cecade32cf48772346303b19ea5a1af275122c1593c631e6d846549dd0" "81c3de64d684e23455236abde277cda4b66509ef2c28f66e059aa925b8b12534" "947190b4f17f78c39b0ab1ea95b1e6097cc9202d55c73a702395fc817f899393" "b46ee2c193e350d07529fcd50948ca54ad3b38446dcbd9b28d0378792db5c088" default))
 '(debug-on-error t)
 '(ein:completion-backend 'ein:use-none-backend)
 '(ein:output-area-inlined-images t)
 '(ein:polymode t)
 '(elfeed-feeds '("https://nyaa.si/?page=rss"))
 '(global-display-line-numbers-mode t)
 '(global-emojify-mode t)
 '(global-emojify-mode-line-mode t)
 '(helm-completion-style 'emacs)
 '(helm-minibuffer-history-key "M-p")
 '(load-prefer-newer t)
 '(ob-ein-languages
   '(("ein-python" . python)
     ("ein-R" . R)
     ("ein-r" . R)
     ("ein-julia" . julia)))
 '(org-agenda-search-headline-for-time nil)
 '(org-agenda-skip-additional-timestamps-same-entry t)
 '(org-agenda-skip-timestamp-if-deadline-is-shown nil)
 '(org-babel-load-languages
   '((js . t)
     (java . t)
     (python . t)
     (emacs-lisp . t)
     (ein . t)
     (shell . t)
     (ditaa . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-export-use-babel nil)
 '(org-html-htmlize-output-type 'css)
 '(org-html-preamble-format '(("en" "<p>%t</p></p>%d</p>")))
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-eww org-gnus org-info org-irc org-mhe org-rmail org-w3m))
 '(org-refile-targets
   '((org-agenda-files :regexp . "*")
     (org-agenda-files :maxlevel . 5)))
 '(org-screenshot-image-directory "/tmp/images/")
 '(org-src-tab-acts-natively t)
 '(package-check-signature nil)
 '(package-selected-packages
   '(org-roam-ui ox-jira dired-sidebar dired-subtree xah-find ox-reveal nov org-noter blacken command-log-mode org-tree-slide emojify pyim-wbdict all-the-icons use-package helm-core virtualenvwrapper projectile pdf-tools posframe pyim json-mode elisp-format general gif-screencast which-key org-mime evil-collection flycheck tide web-mode rjsx-mode org-bullets magit org-plus-contrib el-get gnu-elpa-keyring-update jedi-core cnfonts ein request-deferred elfeed exec-path-from-shell indium htmlize auctex yasnippet-snippets jedi powerline dracula-theme evil-magit helm org-evil evil org undo-tree))
 '(pdf-view-midnight-colors '("white smoke" . "black"))
 '(smartparens-global-strict-mode t))


(org-babel-load-file (expand-file-name "~/.emacs.d/yaoni.org"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
