;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;          Global keybindings         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remap SPC in evil mode to a leader key

;; Remove SPC from motion state means remove it from all states
;; unless specified otherwise.
;; see: https://github.com/noctuid/evil-guide#global-keybindings-and-evil-states
;; Remember that binding a key in motion state is like binding a key in the normal, visual, and operator states all at once (unless that key is already bound in one of those states).
;(define-key evil-motion-state-map " " nil)
(define-key evil-normal-state-map " " nil)

;(evil-define-key 'normal  'global; this does not work in dired but works in *scratch* and when editing files
(evil-define-key 'normal  'dired-mode-map; this works in dired and *scratch* and when editing files
  (kbd "SPC e") 'evil-end-of-line
  ;; global-set-key expects an interactive command
  (kbd "SPC i e") (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
  (kbd "SPC i l") (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
  (kbd "SPC k") 'describe-key
  (kbd "SPC f") 'describe-function
  (kbd "SPC m u") 'mu4e
  )

;(evil-define-key '(motion normal)  'global; this does not work in dired but works in *scratch* and when editing files
;  (kbd "SPC e") 'evil-end-of-line
;  ;; global-set-key expects an interactive command
;  (kbd "SPC i e") (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
;  (kbd "SPC i l") (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
;  (kbd "SPC k") 'describe-key
;  (kbd "SPC f") 'describe-function
;  (kbd "SPC m u") 'mu4e
;  )
(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))
