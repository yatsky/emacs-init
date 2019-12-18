
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
 '(electric-pair-mode t)
 '(elfeed-feeds (quote ("https://nyaa.si/?page=rss")))
 '(evil-want-keybinding nil)
 '(global-display-line-numbers-mode t)
 '(initial-buffer-choice
   ;; We have to use find-file to open the buffer
   ;; because initial-buffer-choice selects the buffer the function returns.
   ;; instead of visiting/finding the file/directory when given a string.
   (lambda nil
     (find-file
      (if
          (string-equal system-type "gnu/linux")
          "/mnt/c/Users/thoma/Dev" "C:\\Users\\thoma\\Dev"))))
 '(load-prefer-newer t)
 '(mu4e-headers-date-format "%d/%m/%Y")
 '(mu4e-headers-include-related t)
 '(mu4e-headers-skip-duplicates t)
 '(org-agenda-files
   (quote
    ("~/Dev/orgs/Personal.org" "~/Dev/orgs/learnning.org" "c:/Users/thoma/Dev/orgs/QUT.org" "c:/Users/thoma/Dev/orgs/COF.org")))
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
 '(org-directory "c:/Users/thoma/Dev/orgs/")
 '(org-drill-learn-fraction 0.45)
 '(org-drill-maximum-items-per-session 80)
 '(org-export-use-babel nil)
 '(org-html-htmlize-output-type (quote css))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-eww org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill)))
 '(org-refile-targets
   (quote
    ((org-agenda-files :regexp . "*")
     (org-agenda-files :maxlevel . 5))))
 '(org-src-tab-acts-natively t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/"))))
 '(package-check-signature nil)
 '(package-selected-packages
   (quote
    (org-mime evil-collection flycheck tide web-mode rjsx-mode org-bullets magit org-brain org-plus-contrib el-get gnu-elpa-keyring-update jedi-core cnfonts ein request-deferred elfeed exec-path-from-shell indium htmlize auctex yasnippet-snippets jedi neotree powerline dracula-theme evil-magit helm org-evil evil linum-relative org undo-tree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "SauceCodePro Nerd Font" :foundry "outline" :slant normal :weight normal :height 100 :width normal)))))

(require 'package)

;; If we use the package-archive variable, we don't need the following add-to-list
;; they will cause issues and the org elpa was never fetched successfully when this directive was used
;; Add org emacs lisp package archive
;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Add melpa package source when using package list
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; disable sound
(setq visible-bell 1)
(tool-bar-mode -1)

;; Load emacs packages and activate them
;; This must come before configurations of installed packages.
;; Don't delete this line.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/plugins/highlight-tail")
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(add-to-list 'load-path "~/.emacs.d/plugins/evil-surround")
(add-to-list 'load-path "~/.emacs.d/plugins/yaml-mode")
(add-to-list 'load-path "~/.emacs.d/elpa/")
;(require 'linum-relative)
;(linum-on); load linum-relative
(global-display-line-numbers-mode t)
(electric-pair-mode t)

(require 'undo-tree)
(global-undo-tree-mode)

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
(when (require 'evil-collection nil t)
  (evil-collection-init))
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
(evil-mode 1)

;; Remap SPC in evil mode to a leader key

;; Remove SPC from motion state means remove it from all states
;; unless specified otherwise.
;; see: https://github.com/noctuid/evil-guide#global-keybindings-and-evil-states
;; Remember that binding a key in motion state is like binding a key in the normal, visual, and operator states all at once (unless that key is already bound in one of those states).
(define-key evil-motion-state-map " " nil)
(evil-define-key 'motion 'global
  (kbd "SPC e") 'evil-end-of-line
  ;; global-set-key expects an interactive command
  (kbd "SPC i e") (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
  (kbd "SPC i l") (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
  (kbd "SPC k") 'describe-key
  (kbd "SPC f") 'describe-function
  (kbd "SPC m u") 'mu4e
  )

;; evil surround
(require 'evil-surround)
(add-hook 'org-mode-hook 'turn-on-evil-surround-mode)

;; include entries from the Emacs diary into Org mode's agenda
(setq org-agenda-include-diary t)
;; turn on indent mode in Org
(add-hook 'org-mode-hook 'org-indent-mode)
;; (add-hook 'org-mode-hook 'linum-relative-mode)
;; org-drill shortcut for resume
;; "org" because C-h f org-mode RET says that org-mode is defined in org.el
(eval-after-load "org"
    '(define-key org-mode-map (kbd "C-c r") 'org-drill-resume))

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

; ein
(require 'ein)
(require 'ein-notebook)
(require 'ein-subpackages)

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
;; This solves the problem that affects Emacs' speed while displaying Chinese characters
(when (eq system-type 'windows-nt) (setq gc-cons-threshold (* 512 1024 1024))
      (setq gc-cons-percentage 0.5) (run-with-idle-timer 5 t #'garbage-collect)
      ;; 显示垃圾回收信息，这个可以作为调试用
      ;; (setq garbage-collection-messages t)
      )

(require 'cnfonts)
;; 让 cnfonts 随着 Emacs 自动生效。
(cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)

;; highlight-tail

(require 'highlight-tail)
(message "Highlight-tail loaded - now your Emacs will be even more sexy!")
;
; [ here some setq of variables - see CONFIGURATION section below ]
(setq highlight-tail-colors '(;("black" . 0)
                              ("#c75e18" . 0)
                              ("#267bbd" . 66)))
(setq highlight-tail-steps 10)
(setq highlight-tail-timer 0.1)

; Highlight mode always on
; (highlight-tail-mode 1)

; org-brain config
;; org-brain using evil
(evil-set-initial-state 'org-brain-visualize-mode 'emacs)


;; eshell customization
;; from here: http://www.modernemacs.com/post/custom-eshell/
;; code: https://gist.github.com/ekaschalk/f0ac91c406ad99e53bb97752683811a5

(require 'dash)
(require 's)

(defmacro with-face (STR &rest PROPS)
  "Return STR propertized with PROPS."
  `(propertize ,STR 'face (list ,@PROPS)))

(defmacro esh-section (NAME ICON FORM &rest PROPS)
  "Build eshell section NAME with ICON prepended to evaled FORM with PROPS."
  `(setq ,NAME
         (lambda () (when ,FORM
                      (-> ,ICON
                          (concat esh-section-delim ,FORM)
                          (with-face ,@PROPS))))))

(defun esh-acc (acc x)
  "Accumulator for evaluating and concatenating esh-sections."
  (--if-let (funcall x)
      (if (s-blank? acc)
          it
        (concat acc esh-sep it))
    acc))

(defun esh-prompt-func ()
  "Build `eshell-prompt-function'"
  (concat esh-header
          (-reduce-from 'esh-acc "" eshell-funcs)
          "\n"
          eshell-prompt-string))

;; Separator between esh-sections
(setq esh-sep "  ")  ; or " | "

;; Separator between an esh-section icon and form
(setq esh-section-delim " ")

;; Eshell prompt header
(setq esh-header "\n ")  ; or "\n┌─"

;; Eshell prompt regexp and string. Unless you are varying the prompt by eg.
;; your login, these can be the same.
(setq eshell-prompt-regexp " ")   ; or "└─> "
(setq eshell-prompt-string " ")   ; or "└─> "

(esh-section esh-dir
             ;"\xf07c"  ;  (faicon folder)
             "fake-dir"
             (abbreviate-file-name (eshell/pwd))
             '(:foreground "gold" :bold ultra-bold :underline t))

(esh-section esh-git
             ;"\xe907"  ;  (git icon)
	     "fake-git-icon"
             (magit-get-current-branch)
             '(:foreground "pink"))

;(esh-section esh-python
;             "\xe928"  ;  (python icon)
;             pyvenv-virtual-env-name)

(esh-section esh-clock
             ;"\xf017"  ;  (clock icon)
             "fake-clock"
             (format-time-string "%H:%M" (current-time))
             '(:foreground "forest green"))

;; Below I implement a "prompt number" section
(setq esh-prompt-num 0)
(add-hook 'eshell-exit-hook (lambda () (setq esh-prompt-num 0)))
(advice-add 'eshell-send-input :before
            (lambda (&rest args) (setq esh-prompt-num (incf esh-prompt-num))))

(esh-section esh-num
             ;"\xf0c9"  ;  (list icon)
             "fake-num"
             (number-to-string esh-prompt-num)
             '(:foreground "brown"))

;; Choose which eshell-funcs to enable
(setq eshell-funcs (list esh-dir esh-git esh-clock esh-num))

;; Enable the new eshell prompt
(setq eshell-prompt-function 'esh-prompt-func)

;; set magit global keybinding
(global-set-key (kbd "C-x g") 'magit-status)

;; org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; tide for TypeScript
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)

  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  )

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; do not use any tabs
;; this is added to prevent picture mode from inserting tabs
;; while we are drawing ascii images
;; we do not use tabs anyway so leave it globally on
(setq-default indent-tabs-mode nil)

;; Ditaa settings
; disable Artist mode in org-src-mode when editing ditaa code
; this is because Artist mode seems to prevent me from typing arrows (< and >)
(defun setup-ditaa ()
    "Setting up the ditaa env for org-src-mode"
    (message "In ditaa mode %s"(buffer-name))
    (artist-mode-off)
    (picture-mode)
    (display-line-numbers-mode)
  )

(add-hook 'org-src-mode-hook
          (lambda ()
            (if (string-match-p (regexp-quote "ditaa") (buffer-name))
                ;; fixme: need to fix this
                ;; seems to be not calling this function
                (setup-ditaa)
                (message "Not in ditaa mode %s"(buffer-name))
                )))




;; minimum configuration for mu4e

(require 'org-mime)
;; make sure mu4e is in your load-path
(require 'mu4e)
(require 'org-mu4e)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)
;; default
(setq mu4e-maildir "~/.mail/my-gmail")

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
;; (setq mu4e-get-mail-command "offlineimap")
(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a"
  ;; mu4e-html2text-command "w3m -T text/html" ;;using the default mu4e-shr2text
  mu4e-view-prefer-html t
  mu4e-update-interval 180
  mu4e-headers-auto-update t
  mu4e-compose-signature-auto-include nil
  mu4e-compose-format-flowed t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; every new email composition gets its own frame!
;; this conflicts with undo-tree
;; (setq mu4e-compose-in-new-frame t)


(add-hook 'mu4e-view-mode-hook #'visual-line-mode)

;; <tab> to navigate to links, <RET> to open them in browser
(add-hook 'mu4e-view-mode-hook
  (lambda()
;; try to emulate some of the eww key-bindings
(local-set-key (kbd "<RET>") 'mu4e~view-browse-url-from-binding)
(local-set-key (kbd "<tab>") 'shr-next-link)
(local-set-key (kbd "<backtab>") 'shr-previous-link)))
;; spell check
(add-hook 'mu4e-compose-mode-hook
    (defun my-do-compose-stuff ()
       "My settings for message composition."
       (visual-line-mode)
       (org-mu4e-compose-org-mode)
       (use-hard-newlines -1)
       (flyspell-mode)))
;;set up queue for offline email
;;use mu mkdir  ~/Maildir/acc/queue to set up first
(setq smtpmail-queue-mail nil)  ;; start in normal mode

;;from the info manual
(setq mu4e-attachment-dir  "~/Downloads")
(setq mu4e-compose-dont-reply-to-self t)

;; convert org mode to HTML automatically
(setq org-mu4e-convert-to-html t)

;;from vxlabs config
;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)

;; don't ask when quitting
(setq mu4e-confirm-quit nil)

;; something about ourselves
(setq
   user-mail-address "wyatsky@gmail.com"
   user-full-name  "Thomas Wang"
   mu4e-compose-signature
    (concat
      "Thomas\n"
      "http://www.yaoni.xyz\n"))

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "wyatsky@gmail.com" nil))
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;; Use MS Edge to open the link in mu4e view
;; https://www.emacswiki.org/emacs/BrowseUrl
(defun browse-url-ms-edge (url &optional new-window)
  (shell-command
   (concat "\"/mnt/c/Program Files (x86)/Microsoft/Edge Dev/Application/msedge.exe\" " url))
  )
(setq browse-url-browser-function 'browse-url-ms-edge)

(setf (alist-get 'trash mu4e-marks)
      (list :char '("d" . "▼")
            :prompt "dtrash"
            :dyn-target (lambda (target msg)
                          (mu4e-get-trash-folder msg))
            :action (lambda (docid msg target)
                      ;; Here's the main difference to the regular trash mark,
                      ;; no +T before -N so the message is not marked as
                      ;; IMAP-deleted:
                      (mu4e~proc-move docid (mu4e~mark-check-target target) "-N"))))
