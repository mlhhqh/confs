(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ee0785c299c1d228ed30cf278aab82cf1fa05a2dc122e425044e758203f097d2" "dbf0cd368e568e6139bb862c574c4ad4eec1859ce62bc755d2ef98f941062441" default))
 '(package-selected-packages
   '(meow vterm posframe company-quickhelp-terminal company hotfuzz which-key adwaita-dark-theme doom-modeline ace-window eglot-signature-eldoc-talkative evil-escape vertico marginalia timu-macos-theme evil markdown-mode go-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(marginalia-mode 1)
(vertico-mode 1)
(load-theme 'timu-macos)
(global-set-key (kbd "C-c C-c") 'open-config)
(global-set-key (kbd "M-a") 'ace-window)

(defun open-config ()
    "Open Emacs config file in the current buffer."
    (interactive)
    (find-file "~/.config/emacs/init.el"))

(require 'eglot-signature-eldoc-talkative)

;(advice-add #'eglot-hover-eldoc-function
;  :override #'eglot-signature-eldoc-talkative)

(electric-pair-mode 1)
(flymake-mode -1)

(setq eldoc-idle-delay 0.01)
(doom-modeline-mode 1)
(menu-bar-mode -1)
(setq eldoc-echo-area-use-multiline-p nil)
;(setq eglot-put-doc-in-help-buffer nil)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(require 'eglot)
(add-to-list 'eglot-server-programs '((go-mode go-ts-mode) .
    ("gopls" :initializationOptions
      (:hints (:parameterNames t
               :rangeVariableTypes t
               :functionTypeParameters t
               :assignVariableTypes t
               :compositeLiteralFields t
               :compositeLiteralTypes t
               :constantValues t)))))

(setq completion-styles '(hotfuzz))
(add-hook 'evil-insert-state-entry-hook 'my-insert-enter-mode)
(add-hook 'evil-insert-state-exit-hook 'my-insert-exit-mode)

(defun my-insert-enter-mode ()
  (setq display-line-numbers t)
  (setq display-line-numbers-type t))

(defun my-insert-exit-mode ()
  (setq display-line-numbers 'relative)
  (setq display-line-numbers-type 'relative))

(setq doom-modeline-buffer-encoding nil)

(setq doom-modeline-env-version nil)
(setq doom-modeline-column-zero-based nil)

(global-company-mode)
(with-eval-after-load 'company-quickhelp
  (company-quickhelp-terminal-mode 1))
(company-quickhelp-mode)

(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'eglot--managed-mode-hook				     
          (lambda () (progn					     
                       (eldoc--format-doc-buffer t)	     
                       (setq eldoc-echo-area-prefer-doc-buffer t) 
		       (setq eldoc-documentation-strategy 'eldoc-documentation-default)
                       (eldoc-doc-buffer))))			     

(setq display-buffer-alist		    
      `(("*eldoc*"			    
         (display-buffer-in-side-window) 
         (side . bottom)		    
         (window-height . 0.16)	    
         (slot . 0))))		    

(setq eldoc-idle-delay 0.0)
(setq eldoc-documentation-strategy 'eldoc-documentation-default)

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

(setq company-quickhelp-use-propertized-text nil)

(global-word-wrap-whitespace-mode)

(defun my-eglot-after-save ()
  "Function to run after saving a buffer in eglot session."
  (when (bound-and-true-p eglot--managed-mode)
    ;; (eglot-code-action-organize-imports 0 100) ;; How?
    (eglot-format))) ; Replace 'your-command-here' with the command you want to run

(add-hook 'after-save-hook 'my-eglot-after-save)

(evil-mode 1)
(setq evil-escape-key-sequence "jk")
(evil-escape-mode 1)

