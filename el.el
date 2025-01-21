(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defvar my-packages
  '(evil vertico marginalia corfu corfu-candidate-overlay hotfuzz doom-modeline doom-themes mood-one-theme magit markdown-mode transient which-key ace-window rainbow-delimiters treemacs hl-todo highlight-indentation consult ace-window evil-escape corfu evil-goggles dape llama-cpp evil-collection git-gutter git-gutter-fringe magit-delta gptel plz highlight-indent-guides ace-window avy which-key restart-emacs ))

(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

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

;; (setq corfu-auto t
;;       corfu-quit-no-match 'separator) ;; or t

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
   '("a68ec832444ed19b83703c829e60222c9cfad7186b7aea5fd794b79be54146e6"
     "e9d685df93947908816c34446af008825c0ebe2f140d6df068d2d77dcd6b1c0c"
     "11819dd7a24f40a766c0b632d11f60aaf520cf96bd6d8f35bae3399880937970"
     "d35afe834d1f808c2d5dc7137427832ccf99ad2d3d65d65f35cc5688404fdf30"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     default))
 '(eldoc-idle-delay 0.25)
 '(highlight-indent-guides-character 124)
 '(highlight-indent-guides-method 'character)
 '(indent-bars-treesit-scope '((go)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(adwaita-dark-theme auto-dark consult-eglot corfu-candidate-overlay
			dape doom-modeline doom-themes dracula-theme
			evil-collection evil-escape evil-goggles
			git-gutter git-gutter-fringe
			highlight-indentation hl-todo hotfuzz
			indent-bars kind-icon llama-cpp magit
			magit-delta marginalia markdown-mode
			mood-one-theme nerd-icons-corfu plz
			rainbow-delimiters treemacs uwu-theme vertico
			vscode-dark-plus-theme which-key))
 '(treesit-font-lock-level 4))


(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package magit-delta
  :after magit
  :config
  :hook (magit-mode . magit-delta-mode))
  (setq
    magit-delta-default-dark-theme "TwoDark"
    magit-delta-default-light-theme "Github"
    magit-delta-hide-plus-minus-markers nil)
  ;;(magit-delta-mode)

 (load-file "/var/home/dx/Schreibtisch/minuet-ai.el/minuet.el") 

(use-package minuet
    :config
    (setq minuet-provider 'openai-fim-compatible)
    (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:11434/v1/completions")
    ;; an arbitrary non-null environment variable as placeholder
    (plist-put minuet-openai-fim-compatible-options :name "Ollama")
    (plist-put minuet-openai-fim-compatible-options :api-key "TERM")
    (plist-put minuet-openai-fim-compatible-options :model "qwen2.5-coder:1.5b-base")

    (minuet-set-optional-options minuet-openai-fim-compatible-options :max_tokens 256))

;; Llama.cpp offers an OpenAI compatible API
(gptel-make-openai "llama-cpp"          ;Any name
  :stream t                             ;Stream responses
  :protocol "http"
  :host "localhost:8081"                ;Llama.cpp server location
  :models '(test))                    ;Any names, doesn't matter for Llama
;; OPTIONAL configuration

(setq
 gptel-model   'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "localhost:8081"
                 :models '(test)))

(defun setup-corfu ()
  "Enable global-corfu-mode and corfu-popupinfo-mode."
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(setq corfu-auto        t
      corfu-auto-delay  1  
      corfu-auto-prefix 0.25) 
      

;; Write a function that does the following:
;; 1. Enable global-corfu-mode
;; 2. Enable corfu-popupinfo-mode

(defun my-go-ts-mode-setup ()
  (go-ts-mode)
  (eglot-ensure))

(add-to-list 'auto-mode-alist '("\\.go\\'" . my-go-ts-mode-setup))
(add-hook 'go-ts-mode-hook 'setup-corfu)

;; set completion to hotfuzz
(setq completion-styles '(hotfuzz))

(require 'corfu)
(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

;; (use-package kind-icon
;;   :ensure t
;;   :after corfu
;;   ;:custom
;;   ; (kind-icon-blend-background t)
;;   ; (kind-icon-default-face 'corfu-default) ; only needed with blend-background
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
(setq display-line-numbers-type 'relative)
;; (global-visual-line-mode t)
;; (setq word-wrap t) ;; visual-line-mode
