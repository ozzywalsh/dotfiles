(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq column-number-mode t)
(global-display-line-numbers-mode 1)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-want-integration t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;; Vertical completion UI.
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

;; Fuzzy, out-of-order matching in the minibuffer.
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Extra annotations in the minibuffer.
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(use-package consult
  :ensure t
  ;; C-c bindings (mode-specific)
  :bind (("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c b" . consult-bookmark)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ;; Custom bindings
         ("M-y" . consult-yank-pop)
         ("M-g f" . consult-flymake)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)))

;; In-buffer completion popup (counterpart to vertico's minibuffer UI).
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)          ; popup as you type, don't wait for C-M-i
  (corfu-auto-delay 0.15)
  (corfu-cycle t))        ; TAB cycles through candidates

;; TAB completes when there's nothing left to indent.
(setq tab-always-indent 'complete)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (go-mode . eglot-ensure))

;; Format Go code when saving.
(defun my/go-format-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(add-hook 'go-mode-hook #'my/go-format-on-save)

(require 'project)

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'"
  :hook (yaml-mode . eglot-ensure))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(evil-define-key '(normal insert) 'global (kbd "C-p") 'project-find-file)
