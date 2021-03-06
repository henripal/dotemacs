;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defvar my-packages 
  '(evil
    evil-paredit
    smooth-scrolling
    powerline
    ido-ubiquitous
    dtrt-indent
    julia-mode
    elpy
    smex))

(dolist (p my-packages)
    (require-package p)
    (require p))

;; indent and tab
(define-key global-map (kbd "RET") 'newline-and-indent)
;; scroll bar mode off
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; no backup files
(setq make-backup-files nil)
;; no menu
(setq ns-auto-hide-menu-bar -1)
;; tramp
(setq tramp-default-method "ssh")

;; ido & smex stuff
(ido-mode 1)
(ido-everywhere 1)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-x") 'smex-major-mode-commands)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil mode customizations
(evil-mode 1)
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex))
; evil visual lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; visuals
(setq inhibit-startup-screen t)
 (setq mac-allow-anti-aliasing t)  ;; turn off anti-aliasing
(set-face-attribute 'default nil
                    :family "Roboto Mono for Powerline"
                    :height 130
                    :weight 'medium)

(add-to-list 'default-frame-alist '(fullscreen . fullheight))
 (let ((basedir "~/.emacs.d/themes/"))
      (dolist (f (directory-files basedir))
        (if (and (not (or (equal f ".") (equal f "..")))
                 (file-directory-p (concat basedir f)))
            (add-to-list 'custom-theme-load-path (concat basedir f)))))


(load-theme 'material t)
;; tabs
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default c-basic-offset 4 c-default-style "bsd")
(dtrt-indent-mode 1)

;; paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)


(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; smooth scrolling package
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b9cbfb43711effa2e0a7fbc99d5e7522d8d8c1c151a3194a4b176ec17c9a8215" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
