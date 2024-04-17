; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dbf0cd368e568e6139bb862c574c4ad4eec1859ce62bc755d2ef98f941062441" "ee0785c299c1d228ed30cf278aab82cf1fa05a2dc122e425044e758203f097d2" default))
 '(package-selected-packages
   '(eldoc-box corfu company markdown-mode timu-macos-theme adwaita-dark-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Configuration
;;(add-to-list 'treesit-language-source-alist
;;	     '(typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))
(load "~/.config/emacs/ui.el")
(setq treesit-font-lock-level 4)
(electric-pair-mode t)

;; (global-company-mode t)
;; (setq company-idle-delay 0)
;; (setq company-minimum-prefix-length 0)
;; (company-selection-wrap-around t)

;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t
(setq corfu-auto        t
            corfu-auto-delay  0 ;; TOO SMALL - NOT RECOMMENDED
            corfu-auto-prefix 1 ;; TOO SMALL - NOT RECOMMENDED
            completion-styles '(basic))
(corfu-popupinfo-mode)
(global-corfu-mode t)

(load-theme 'timu-macos)

(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 160
                    :weight 'normal
                    :width 'normal)

(setq corfu-popupinfo-delay 0)
(eldoc-box-hover-at-point-mode t)
