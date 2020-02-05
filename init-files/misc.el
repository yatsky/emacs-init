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
(setq ac-max-width 0.1)

;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(yas-global-mode 1)

; js2 minor mode
;(add-hook 'js-mode-hook 'js2-minor-mode)

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

;; pyim
(require 'posframe)
(require 'pyim)
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)
;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
;; 手动安装 posframe 包。
(setq pyim-page-tooltip 'posframe)
;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; 我自己使用的中英文动态切换规则是：
;; 1. 光标只有在注释里面时，才可以输入中文。
;; 2. 光标前是汉字字符时，才能输入中文。
;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
(setq-default pyim-english-input-switch-functions
            '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))
(global-set-key (kbd"M-j") 'pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
(global-set-key (kbd"C-;") 'pyim-delete-word-from-personal-buffer)
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

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'helm-config)
(helm-mode 1)
