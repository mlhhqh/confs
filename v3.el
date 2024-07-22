(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defun open-config ()
  "Open my local init.el"
  (interactive)
  (find-file "~/.config/emacs/init.el"))

(global-set-key (kbd "C-c C-c") 'open-config)
(global-set-key (kbd "M-a") 'ace-window)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f"
     "2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15"
     "f490984d405f1a97418a92f478218b8e4bcc188cf353e5dd5d5acd2f8efd0790"
     "ee0785c299c1d228ed30cf278aab82cf1fa05a2dc122e425044e758203f097d2"
     "993aac313027a1d6e70d45b98e121492c1b00a0daa5a8629788ed7d523fe62c1"
     default))
 '(package-selected-packages
   '(ace-window adwaita-dark-theme company company-quickhelp
		company-quickhelp-terminal compat consult evil
		evil-escape evil-textobj-tree-sitter gptel hotfuzz
		marginalia markdown-mode poet-theme vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default evil-escape-key-sequence "jk")
(evil-mode)
(evil-escape-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq treesit-font-lock-level 4)
(global-company-mode 1)
(setq company-minimum-prefix-length 1)
(electric-pair-mode 1)

(use-package indent-bars
  :load-path "~/Schreibtisch/indent-bars"
  :config
  (require 'indent-bars-ts) 		; not needed with straight
  :custom
  (indent-bars-treesit-support t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  ;; Add other languages as needed
  (indent-bars-treesit-scope '((python function_definition class_definition for_statement
	  if_statement with_statement while_statement)))
  ;; wrap may not be needed if no-descend-list is enough
  ;;(indent-bars-treesit-wrap '((python argument_list parameters ; for python, as an example
  ;;				      list list_comprehension
  ;;				      dictionary dictionary_comprehension
  ;;				      parenthesized_expression subscript)))
  :hook ((python-base-mode yaml-mode) . indent-bars-mode))


(defun enable-line-numbers ()
  (interactive)
  (display-line-numbers-mode)
  (setq display-line-numbers 'relative))

(defun disable-relative-numbers ()
  (setq display-line-numbers nil)
  (display-line-numbers-mode)
  )

(add-hook 'evil-insert-state-exit-hook 'enable-line-numbers)
(add-hook 'evil-insert-state-entry-hook  'disable-relative-numbers)

(vertico-mode)
(marginalia-mode)
(setq visible-bell t)
(setq display-line-numbers 'relative) ;; This doesnt seem to apply globally
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative) ;; This doesnt seem to apply globally
(global-company-mode)
;(company-quickhelp-mode)

(setq completion-styles '(hotfuzz))
(scroll-bar-mode -1)

(defun eglot-find-references ()
  (interactive)
  (xref-find-references))

(defun eglot-show-symbols ()
  (interactive)
  (consult-imenu))

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(add-hook 'eglot-managed-mode-hook 'indent-bars-mode)
(load-theme 'adwaita-dark)
(toggle-word-wrap)
(global-visual-wrap-prefix-mode)

(setq eldoc-idle-delay 0.01)
;; (setq evil-textobj)
;; bind `function.outer`(entire function block) to `f` for use in things like `vaf`, `yaf`
(define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
;; bind `function.inner`(function block without name and args) to `f` for use in things like `vif`, `yif`
(define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))

;; You can also bind multiple items and we will match the first one we can find
(define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj ("conditional.outer" "loop.outer")))


(add-to-list 'load-path "~/.config/emacs/emacs-application-framework/")
(require 'eaf)
(require 'eaf-browser)
(global-set-key (kbd "C-x b") 'consult-buffer)


;; OPTIONAL configuration
(setq
 gptel-model   "test"
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "localhost:8080"
                 :models '("test")))
(add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)
(add-hook 'gptel-post-response-functions 'gptel-end-of-response)
