(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defvar my-packages
  '(evil vertico marginalia corfu corfu-candidate-overlay hotfuzz doom-modeline doom-themes mood-one-theme magit markdown-mode transient which-key ace-window rainbow-delimiters treemacs hl-todo highlight-indentation consult ace-window evil-escape corfu evil-goggles dape llama-cpp evil-collection))  ;; replace with your list of packages

(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers 'relative)
(setq word-wrap t)

(vertico-mode 1)
(marginalia-mode 1)
(rainbow-delimiters-mode 1)

(setq evil-want-keybinding nil) ; https://github.com/emacs-evil/evil-collection/issues/60
(evil-mode)

(load-theme 'dracula t)
;; Enable auto completion and configure quitting

(evil-escape-mode 1)
(setq evil-escape-key-sequence "jk")
(delete 'visual evil-escape-excluded-states)

(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

(setq evil-goggles-pulse t) ;; default is to pulse when running in a graphic display

;;(setq eldoc-documentation-functions '(eglot-signature-eldoc-function eglot-signature-eldoc-function t flymake-eldoc-function))

(evil-collection-init)

(setq llama-cpp-chat-prompt-prefix "<|im_start|>system\n"
      llama-cpp-chat-input-prefix "<|im_start|>user\n"
      llama-cpp-chat-input-suffix "<|im_end|>\n<|im_start|>assistant\n")

(add-hook 'eglot-managed-mode-hook
	  (lambda ()
	    (setq-local treesit-font-lock-level 4)
	    (setq-local eldoc-echo-area-use-multiline-p nil)
	    (setq-local eldoc-documentation-functions
			'(eglot-hover-eldoc-function
			  eglot-signature-eldoc-function
			  flymake-eldoc-function))))

(unless package-archive-contents
  (package-refresh-contents))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed)))))
	        ;;
;;(load-theme 'doom-one t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("11819dd7a24f40a766c0b632d11f60aaf520cf96bd6d8f35bae3399880937970" "d35afe834d1f808c2d5dc7137427832ccf99ad2d3d65d65f35cc5688404fdf30" "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(vscode-dark-plus-theme evil-escape which-key vertico uwu-theme treemacs rainbow-delimiters mood-one-theme markdown-mode marginalia magit llama-cpp hotfuzz hl-todo highlight-indentation evil-goggles evil-collection dracula-theme doom-themes doom-modeline dape corfu-candidate-overlay consult-eglot adwaita-dark-theme))
 '(treesit-font-lock-level 4))

(global-visual-line-mode t)
