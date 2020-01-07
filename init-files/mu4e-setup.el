(defun load-mu4e ()
  "Load mu4e"

  ;; minimum configuration for mu4e

  (require 'org-mime)
  ;; make sure mu4e is in your load-path
  (require 'mu4e)
  (require 'org-mu4e)

  ;; use mu4e for e-mail in emacs
  (setq mail-user-agent 'mu4e-user-agent)
  ;; default
  (setq mu4e-maildir (expand-file-name "~/.mail"))

                                        ; (setq mu4e-drafts-folder "/[Gmail].Drafts")
                                        ; (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
                                        ; (setq mu4e-trash-folder  "/[Gmail].Trash")

  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  ;; Testing shows that office 365 also works with this setting.
  (setq mu4e-sent-messages-behavior 'delete)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)


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
  ;;rename files when moving
  ;;NEEDED FOR MBSYNC
  (setq mu4e-change-filenames-when-moving t)
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
  (require 'smtpmail)

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
  ;; mu4e-context
  (require 'mu4e-context)
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "personal" ;;for my-gmail
          :enter-func (lambda () (mu4e-message "Entering context personal"))
          :leave-func (lambda () (mu4e-message "Leaving context personal"))
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches
                           msg '(:from :to :cc :bcc) "wyatsky@gmail.com")))
          :vars '((user-mail-address . "wyatsky@gmail.com")
                  (user-full-name . "Thomas")
                  (mu4e-sent-folder . "/my-gmail/[Gmail].Sent Mail")
                  (mu4e-drafts-folder . "/my-gmail/[Gmail].drafts")
                  (mu4e-trash-folder . "/my-gmail/[Gmail].Bin")
                  (mu4e-compose-signature . (concat "Thomas Wang\n" "Emacs 25, org-mode 9, mu4e 1.0\n"))
                  (mu4e-compose-format-flowed . t)
                  (smtpmail-queue-dir . "~/.mail/my-gmail/queue/cur")
                  (message-send-mail-function . smtpmail-send-it)
                  (smtpmail-smtp-user . "wyatsky")
                  (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
                  (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
                  (smtpmail-default-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-debug-info . t)
                  (smtpmail-debug-verbose . t)
                  (mu4e-maildir-shortcuts . ( ("/my-gmail/INBOX"            . ?i)
                                              ("/my-gmail/[my].Sent Mail" . ?s)
                                              ("/my-gmail/[my].Bin"       . ?t)
                                              ("/my-gmail/[my].All Mail"  . ?a)
                                              ("/my-gmail/[my].Starred"   . ?r)
                                              ("/my-gmail/[my].drafts"    . ?d)
                                              ))))
         (make-mu4e-context
          :name "qut" ;;for acc2-gmail
          :enter-func (lambda () (mu4e-message "Entering context work"))
          :leave-func (lambda () (mu4e-message "Leaving context work"))
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches
                           msg '(:from :to :cc :bcc) "wangy95@qut.edu.au")))
          :vars '((user-mail-address . "wangy95@qut.edu.au")
                  (user-full-name . "Yi Wang")
                  (mu4e-sent-folder . "/QUT/[QUT].Sent Mail")
                  (mu4e-drafts-folder . "/QUT/[QUT].drafts")
                  (mu4e-trash-folder . "/QUT/[QUT].Trash")
                  (mu4e-compose-signature . (concat "Cheers\n" "Emacs is awesome!\n"))
                  (mu4e-compose-format-flowed . t)
                  (smtpmail-queue-dir . "~/.mail/QUT/queue/cur")
                  (message-send-mail-function . smtpmail-send-it)
                  (smtpmail-smtp-user . "wangy95@qut.edu.au")
                  (smtpmail-starttls-credentials . (("smtp.office365.com" 587 nil nil)))
                  (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
                  (smtpmail-default-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-debug-info . t)
                  (smtpmail-debug-verbose . t)
                  (mu4e-maildir-shortcuts . ( ("/QUT/INBOX"            . ?i)
                                              ))))

         (make-mu4e-context
          :name "uq" ;;for acc2-gmail
          :enter-func (lambda () (mu4e-message "Entering context work"))
          :leave-func (lambda () (mu4e-message "Leaving context work"))
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches
                           msg '(:from :to :cc :bcc) "y.wang7@uqconnect.edu.au")))
          :vars '((user-mail-address . "y.wang7@uqconnect.edu.au")
                  (user-full-name . "Yi Wang")
                  (mu4e-sent-folder . "/uq/[uq].Sent Mail")
                  (mu4e-drafts-folder . "/uq/[uq].drafts")
                  (mu4e-trash-folder . "/uq/[uq].Trash")
                  (mu4e-compose-signature . (concat "Cheers\n" "Emacs is awesome!\n"))
                  (mu4e-compose-format-flowed . t)
                  (smtpmail-queue-dir . "~/.mail/uq/queue/cur")
                  (message-send-mail-function . smtpmail-send-it)
                  (smtpmail-smtp-user . "y.wang7@uqconnect.edu.au")
                  (smtpmail-starttls-credentials . (("smtp.office365.com" 587 nil nil)))
                  (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
                  (smtpmail-default-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-server . "smtp.office365.com")
                  (smtpmail-smtp-service . 587)
                  (smtpmail-debug-info . t)
                  (smtpmail-debug-verbose . t)
                  (mu4e-maildir-shortcuts . ( ("/uq/INBOX"            . ?i)
                                              ))))))
  ;; bookmarks

  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name  "No Trash Unread"
                :query "date:today..now AND NOT Maildir:/QUT/[QUT].Trash AND NOT Maildir:/my-gmail/[Gmail].Bin"
                :key ?U))
  
  )

(defun load-mu4e-on-gnu-linux ()
  "Load mu4e if the os is gnu/linux"
  (if (is-gnu-linux)
      (load-mu4e)))
(load-mu4e-on-gnu-linux)
