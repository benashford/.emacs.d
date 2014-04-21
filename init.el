;; Packages

(setq package-list '(ac-nrepl
                     ack-and-a-half
                     anti-zenburn-theme
                     auto-complete
                     cider
                     clojure-mode
                     flx-ido
                     flycheck
                     git-gutter
                     paredit
                     projectile
                     smex
                     rainbow-delimiters
                     rbenv
                     undo-tree
                     yaml-mode))

(require 'package)
(add-to-list 'package-archives
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; No backup files (that's what version control is for)

(setq make-backup-files nil)

;; KEYS

(define-key global-map (kbd "RET") 'newline-and-indent)

;; THEMES

;; no theme
;; (unless (equal "xterm-256color" (tty-type))
;;     (load-theme 'anti-zenburn t))

;; FONTS

(set-face-attribute 'default nil :family "PragmataPro" :height 130)

;; MODES

(setq display-time-24hr-format t)
(display-time-mode 1)
(column-number-mode)
(size-indication-mode)
(global-rbenv-mode)

(require 'flx-ido)
(ido-mode t)
(ido-everywhere t)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(show-paren-mode)
(global-auto-revert-mode t)

(projectile-global-mode)

(undo-tree-mode)

(tool-bar-mode 0)

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 90)
(global-whitespace-mode t)

;; uniquify
(require 'uniquify)

;;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;; flycheck

(add-hook 'after-init-hook #'global-flycheck-mode)

;;; git gutter

(require 'git-gutter)
(global-git-gutter-mode t)

(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign "-")
(setq git-gutter:modified-sign "=")

(setq git-gutter:separator-sign " ")
(set-face-background 'git-gutter:separator "color-233")

(setq git-gutter:hide-gutter t)

;;; emacs-lisp-mode

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;;; vcl-mode

(autoload 'vcl-mode "vcl-mode" "VCL Mode." t)
(add-to-list 'auto-mode-alist '("\\.vcl$" . vcl-mode))

;;; ruby-mode

(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))

;;; clojure-mode

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))

;; midje mode no key hijacking

(defun disable-midje-keys ()
  (define-key midje-mode-map "\C-c" nil))
(add-hook 'midje-mode-hook 'disable-midje-keys)

;;; cider-mode

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

;; KEYS

(fset 'insertHash
      "#")
(global-unset-key (kbd "M-3"))
(global-set-key (kbd "M-3") 'insertHash)

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key (kbd "<mouse-4>") 'down-slightly)
(global-set-key (kbd "<mouse-5>") 'up-slightly)

(when (equal "xterm-256color" (tty-type))
  (define-key input-decode-map "\e[1;2A" [S-up])
  (xterm-mouse-mode t)
  (menu-bar-mode 0))

(windmove-default-keybindings)

;; Tabs and stuff
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; smex

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; Copying a pasting
(defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; DO NOT EDIT
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1f70ca6096c886ca2a587bc10e2e8299ab835a1b95394a5f4e4d41bb76359633" "375cb420cbbe427fb84a21915f8b271978db9aa70513fd71e85fc7047faca879" "ee6081af57dd389d9c94be45d49cf75d7d737c4a78970325165c7d8cb6eb9e34" "e7af2246eff56872b197ee7493563a5ffa26022ca813b02c28c8e9f19f742678" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "bf648fd77561aae6722f3d53965a9eb29b08658ed045207fe32ffed90433eb52" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
