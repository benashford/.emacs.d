;; Packages

(setq package-list '(ac-nrepl
                     ace-jump-mode
                     ack-and-a-half
                     ag
                     auto-complete
                     browse-kill-ring
                     cider
                     clojure-mode
                     color-theme-sanityinc-tomorrow
                     flx-ido
                     flycheck
                     git-gutter
                     magit
                     markdown-mode
                     mustache-mode
                     paredit
                     projectile
                     puppet-mode
                     smartparens
                     smex
                     rainbow-delimiters
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

(load-theme 'sanityinc-tomorrow-bright t)

;; FONTS

(set-face-attribute 'default nil :family "PragmataPro" :height 130)

;; MODES

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

;;; smartparens

(require 'smartparens-config)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)
(show-smartparens-global-mode t)

(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

(define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)

(define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
(define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)
(define-key sp-keymap (kbd "C-M-t") 'sp-transpose-sexp)

(define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
(define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)

(define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "C-M-w") 'sp-copy-sexp)

(define-key sp-keymap (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key sp-keymap (kbd "M-D") 'sp-splice-sexp)
(define-key sp-keymap (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key sp-keymap (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key sp-keymap (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key sp-keymap (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key sp-keymap (kbd "C-M-]") 'sp-select-next-thing)

(define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)

(define-key sp-keymap (kbd "H-t") 'sp-prefix-tag-object)
(define-key sp-keymap (kbd "H-p") 'sp-prefix-pair-object)
(define-key sp-keymap (kbd "H-s c") 'sp-convolute-sexp)
(define-key sp-keymap (kbd "H-s a") 'sp-absorb-sexp)
(define-key sp-keymap (kbd "H-s e") 'sp-emit-sexp)
(define-key sp-keymap (kbd "H-s p") 'sp-add-to-previous-sexp)
(define-key sp-keymap (kbd "H-s n") 'sp-add-to-next-sexp)
(define-key sp-keymap (kbd "H-s j") 'sp-join-sexp)
(define-key sp-keymap (kbd "H-s s") 'sp-split-sexp)

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

(unless (getenv "TMUX")
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

;; kill-ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
