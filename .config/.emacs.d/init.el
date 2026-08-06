(setq custom-file "~/.emacs.d/emacs.custom.el")
(load-file custom-file)

;; disable splash entry
(setq-default inhibit-splash-screen t
	      make-backup-files nil
	      tab-width 4
	      indend-tabs-mode nil
	      compilation-scroll-output t)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
			 '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))

(set-face-attribute 'region nil
                    :inverse-video t)

(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-\"" . mc/skip-to-next-like-this)
   ("C-:" . mc/skip-to-previous-like-this)))

(use-package ido-completing-read+
  :ensure t
  :init (ido-ubiquitous-mode 1))

(use-package smex
  :ensure t
  :bind
  (("M-x" . smex)))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
		 ("\\.md\\'" . markdown-mode)
		 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package anaconda-mode
  :hook (python-mode . anaconda-mode))

(use-package pyvenv
  :config
  (pyvenv-mode 1)
  (setq pyvenv-default-virtual-env-name "venv"))

(use-package eglot
  :ensure nil
  :hook (simpc-mode . eglot-ensure)
  :bind (:map eglot-mode-map
			  ("M-." . xref-find-definitions)
			  ("M-," . xref-go-back)
			  ("C-c C-d" . eldoc-doc-buffer)))

(add-to-list 'display-buffer-alist
			 '("\\*eldoc\\*"
			   (display-buffer-in-side-window)
			   (side . bottom)
			   (window-height . 0.3)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   '(simpc-mode . ("clangd"))))

;; Options
(setq-default display-line-numbers-type 'relative)
(add-to-list 'default-frame-alist
             '(font . "BigBlueTerm437NerdFontMono-13"))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(ido-mode 1)
(ido-everywhere 1)

;; windown movement
(global-set-key (kbd "C-; h") #'windmove-left)
(global-set-key (kbd "C-; l") #'windmove-right)
(global-set-key (kbd "C-; k") #'windmove-up)
(global-set-key (kbd "C-; j") #'windmove-down)

;; mistic
(add-to-list 'load-path "~/.emacs.d/.emacs.local/")

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; keys
(global-set-key (kbd "C-c C-c M-x") 'execute-extend-command)

(global-set-key (kbd "C-,") 'duplicate-line)

(global-set-key (kbd "C-c o") #'browse-url-at-point)

(global-set-key (kbd "C-x k") 'kill-buffer-and-window)

(global-set-key (kbd "C-x M-c") 'compile)

;; command keys
(defun cmd/curl ()
  (interactive)
  (async-shell-command (format "curl --http2 -ski %s" (thing-at-point 'url t))
					    "*curl*"))
(global-set-key (kbd "C-! c") #'cmd/curl)

(defun cmd/tcp_nmap (ip)
  (interactive "sTarget IP: ")
  (async-shell-command (format "nmap -sC -sV -vv --reason -p- -oN tcp.out %s"
							   ip)
					   "*nmap scan*"))
(global-set-key (kbd "C-! n") #'cmd/tcp_nmap)

(defun cmd/fast_tcp_nmap (ip)
  (interactive "sTarget IP: ")
  (async-shell-command (format "nmap -sC -sV -vv --reason --min-rate 5000 -p- -oN tcp.out %s"
							   ip)
					   "*fast nmap scan*"))
(global-set-key (kbd "C-! S-n") #'cmd/fast_tcp_nmap)

(defun cmd/ffuf_dir (target wordlist threads delay)
  (interactive
   (list
	(read-string    "Target: ")
	(read-file-name "Wordlist: ")
	(read-string    "Threads: ")
	(read-string    "Delay: "))
   (async-shell-command (format "ffuf -c -u \"%s/FUZZ\" -w %s -ac -t %s -p \"%s\""
								target wordlist threads delay)
					   "*fuzzing dir*")))
(global-set-key (kbd "C-! C-f d") #'cmd/ffuf_dir)
;; ffuf command for subdomains
(defun cmd/ffuf_sub (target wordlist threads delay)
  (interactive
   (list
	(read-string    "Target: ")
	(read-file-name "Wordlist: ")
	(read-string    "Threads: ")
	(read-string    "Delay: "))
   (async-shell-command (format "ffuf -c -u \"%s\" -H \"Host: FUZZ.%s\" -w %s -ac -t %s -p \"%s\""
								target (replace-regexp-in-string "^https?://" "" target)
								wordlist threads delay)
					   "*fuzzing subs*")))
(global-set-key (kbd "C-! C-f s") #'cmd/ffuf_sub)
