;; disable sound
(setq visible-bell 1)
(tool-bar-mode -1)
(global-display-line-numbers-mode t)
(electric-pair-mode t)

(global-undo-tree-mode)

(load-theme 'dracula t)
(require 'powerline)
(powerline-center-evil-theme)


;; yaml support
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))



;; wrap lines
(global-visual-line-mode 1)

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)    ;optional

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(yas-global-mode 1)

; js2 minor mode
(add-hook 'js-mode-hook 'js2-minor-mode)

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
;; This solves the problem that affects Emacs' speed while displaying Chinese characters
(when (eq system-type 'windows-nt) (setq gc-cons-threshold (* 512 1024 1024))
      (setq gc-cons-percentage 0.5) (run-with-idle-timer 5 t #'garbage-collect)
      ;; 显示垃圾回收信息，这个可以作为调试用
      ;; (setq garbage-collection-messages t)
      )

;; 让 cnfonts 随着 Emacs 自动生效。
(cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)

;; set magit global keybinding
(global-set-key (kbd "C-x g") 'magit-status)


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



(which-key-mode)
(setq gif-screencast-output-directory (cons org-directory "screencasts"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;           Frame and Window           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-frame-size (selected-frame) 1350 950 t)
(defmacro gen-frame-size-func (w-or-h inc)
  "inc/dec-frame-width/height"
;(set-frame-height (selected-frame) (+ (frame-native-height (selected-frame)) 20) nil t)
  ; use let* so that we can refer to the `inc-or-dec' right away in `let'.
  (let* ((set-func (intern (concat "set-frame-" w-or-h)))
        (get-func (intern (concat "frame-native-" w-or-h)))
;; not sure why but it seems 20 is the minimum offset required for the change to take effect
        (value (if (string-equal w-or-h "width") 40 40))
        (inc-or-dec (if inc "inc" "dec"))
        (doc (format "%s the current frame %s." inc-or-dec w-or-h))
        (positive (if inc 1 -1)))

    ; The comma `,' causes Emacs to evaluate everything in the list it precedes
    ; so there is no need to place a comma before the variables in the list
    ; if you want it to be evaluated.
    ;FIXME: Need to figure out what @ does.
    `(defun ,(intern (concat inc-or-dec "-frame-" w-or-h)) ()
       ,doc
       (interactive)
        (message ,(number-to-string (* positive value)))
         (,set-func (selected-frame) (+ (,get-func (selected-frame)) ,(* positive value)) nil t)
         )
    )
  )
(gen-frame-size-func "width" t)
(gen-frame-size-func "width" nil)
(gen-frame-size-func "height" nil)
(gen-frame-size-func "height" t)
