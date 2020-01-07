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

;; evil surround
(require 'evil-surround)
(add-hook 'org-mode-hook 'turn-on-evil-surround-mode)
; org-brain config
;; org-brain using evil
(evil-set-initial-state 'org-brain-visualize-mode 'emacs)
