;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;              Org-global             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-directory (concat (get-wd) "/orgs/"))
;; include entries from the Emacs diary into Org mode's agenda
(setq org-agenda-include-diary t)
;; turn on indent mode in Org
(add-hook 'org-mode-hook 'org-indent-mode)

;; capture
(setq org-default-notes-file (concat org-directory "capture/quick_notes.org"))

;; cater for whitespace sensetive languages
(setq org-edit-src-content-indentation 4)
(setq org-src-fontify-natively t)
(setq org-src-preserve-indentation t)

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
;; set effort estimates
(setq org-global-properties (quote (("Effort_ALL" . "0:05 0:10 0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;                Agenda               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Agenda
(defun org-agenda-files-paths (cur-wd list)
  "Generate a list of file paths based on `get-wd' for variable `org-agenda-files'"
  (let (new-list)
    (dolist (element list new-list)
      (setq new-list (cons (concat cur-wd element) new-list)))))

(setq org-agenda-files
      (cons org-default-notes-file (org-agenda-files-paths org-directory '("Personal.org" "learnning.org" "QUT.org" "COF.org")))
      )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;           ob-lang settings          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable python source code eval
(require 'ob-python)
;; enable javascript source code eval
(require 'ob-js)
;;(add-to-list 'org-babel-load-languages '(js . t))
(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
(add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;             My org seup             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-org-setup ()
  "Set up my org settings."
  (define-key org-mode-map (kbd "C-c t") (kbd "C-u M-x org-time-stamp"))
  (define-key org-mode-map (kbd "C-c r") 'org-drill-resume)
  (require 'ox-md nil t)

  (defun search-word ()
    (interactive)
    (let ((cur-word (thing-at-point 'word)))
     ;(message "The word is %s" cur-word)
      (shell-command (concat "\"/mnt/c/Program Files (x86)/Microsoft/Edge Dev/Application/msedge.exe\" https://duckduckgo.com/?q=" cur-word))
      )
    )
  (define-key org-mode-map (kbd "C-c g") 'search-word)
)

(with-eval-after-load "org"
   (my-org-setup)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;             org-modules             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

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
