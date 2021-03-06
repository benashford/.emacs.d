;; Packages

(setq package-list '(ace-jump-mode
                     ag
                     browse-kill-ring
                     cider
                     clj-refactor
                     clojure-mode
                     color-theme-sanityinc-tomorrow
                     company
                     docker
                     dockerfile-mode
                     flx-ido
                     flycheck
                     git-gutter
                     git-timemachine
                     groovy-mode
                     go-mode
                     julia-mode
                     julia-shell
                     lua-mode
                     magit
                     markdown-mode
                     mustache-mode
                     nginx-mode
                     paredit
                     projectile
                     puppet-mode
                     smex
                     rainbow-delimiters
                     rust-mode
                     undo-tree
                     web-mode
                     yaml-mode))

(require 'package)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

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

(if (equal "xterm-256color" (tty-type))
  (load-theme 'sanityinc-tomorrow-bright t)
  (load-theme 'sanityinc-tomorrow-night t))

;; FONTS

(if (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "PragmataPro" :height 130)
  (set-face-attribute 'default nil :family "Fantasque Sans Mono" :height 115))

(setq display-time-24hr-format t)
(display-time-mode 1)
(column-number-mode)
(size-indication-mode)

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
(setq whitespace-style '(face empty lines-tail trailing))
(setq whitespace-line-column 90)
(global-whitespace-mode t)

;; uniquify
(require 'uniquify)

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

;; Company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Ace jump mode

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-c C-u SPC") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c C-u C-c SPC") 'ace-jump-line-mode)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)

(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;; emacs-lisp-mode

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;;; vcl-mode

(autoload 'vcl-mode "vcl-mode" "VCL Mode." t)
(add-to-list 'auto-mode-alist '("\\.vcl$" . vcl-mode))

;;; ruby-mode

(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))

;;; groovy-mode
(add-to-list 'auto-mode-alist '("Jenkinsfile\\'" . groovy-mode))

;;; clojure-mode

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'magic-mode-alist '(".* boot" . clojure-mode))

;; midje mode no key hijacking

(defun disable-midje-keys ()
  (define-key midje-mode-map "\C-c" nil))
(add-hook 'midje-mode-hook 'disable-midje-keys)

;;; clj-refactor-mode

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;;; mustache-mode

(require 'mustache-mode)

;;; cider-mode

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;;; web-mode

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;;; JavaScript mode
(setq js-indent-level 2)

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
  (xterm-mouse-mode t))

(menu-bar-mode 0)

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

(unless (getenv "TMUX")
  (when (eq system-type 'darwin)
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)))

;; kill-ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; No startup screen
(setq inhibit-startup-screen t)
