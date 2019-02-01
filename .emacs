
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun compile-single-c++-file ()
  (interactive)
  (shell-command (concat "g++ " buffer-file-name " -o " (file-name-sans-extension buffer-file-name))))

(defun kattis-run ()
  (interactive)
  (save-buffer)
  (defconst file-buffer (current-buffer))
  (defconst file-name buffer-file-name)
  (defconst file-name-short (file-name-sans-extension file-name))
  (get-buffer-create "Output")
  (kill-buffer "Output")
  (switch-to-buffer-other-window (get-buffer-create "Output") 1)
  (if (or (equal (file-name-extension file-name) "c++") (equal (file-name-extension file-name) "cpp") )
      (progn ;(delete-file (concat file-name-short ".err"))
;	(shell-command (concat "g++ " file-name " -o " file-name-short " 2>&1 | tee " file-name-short ".err")) ;TODO: make a function out o diss
	     (if (equal (call-process "g++" nil "Output" t file-name "-o" file-name-short) 0)
		 (progn
		   (setq ins (directory-files (file-name-directory file-name) nil ".*\.in$"))
		   (setq anss (directory-files (file-name-directory file-name) nil ".*\.ans$"))
		   (while ins
		    ;(shell-command (concat "" file-name-short " < " (car ins) " 2>&1 | tee " (file-name-sans-extension (car ins)) ".out"))
		     (call-process file-name-short (car ins) "Output" t)
;		    (shell-command (concat "comm -3 " (file-name-sans-extension (car ins)) ".out " (car anss) " > " (file-name-sans-extension (car ins)) ".diff"))
			  (setq ins (cdr ins))
			  (setq anss (cdr anss))))
	       ;(print "Error in compilation")
	       ))
    (print "Error: file is not a c++ file"))
  (other-window -1))

(global-set-key (kbd "C-x C-k") 'kattis-run) ; run and test for kattis
(global-set-key (kbd "C-c C-f") 'clang-format-buffer) ; nice formatting TODO make it format everything
(global-set-key (kbd "C-c C-_") 'comment-or-uncomment-region)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-output-view-style
   (quote
	(("^dvi$"
	  ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$")
	  "%(o?)dvips -t landscape %d -o && gv %f")
	 ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f")
	 ("^dvi$"
	  ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "^landscape$")
	  "%(o?)xdvi %dS -paper a4r -s 0 %d")
	 ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "%(o?)xdvi %dS -paper a4 %d")
	 ("^dvi$"
	  ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$")
	  "%(o?)xdvi %dS -paper a5r -s 0 %d")
	 ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$" "%(o?)xdvi %dS -paper a5 %d")
	 ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d")
	 ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d")
	 ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d")
	 ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d")
	 ("^dvi$" "." "%(o?)xdvi %dS %d")
	 ("^pdf$" "." "xpdf -remote %s -raise %o %(outpage)")
	 ("^html?$" "." "firefox %o"))))
 '(TeX-view-program-selection
   (quote
	(((output-dvi has-no-display-manager)
	  "dvi2tty")
	 ((output-dvi style-pstricks)
	  "dvips and gv")
	 (output-dvi "xdvi")
	 (output-pdf "Zathura")
	 (output-html "xdg-open"))))
 '(custom-safe-themes
   (quote
	("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(package-selected-packages
   (quote
	(evil auctex prolog haskell-mode multiple-cursors multi-web-mode ssh company-go graphviz-dot-mode hc-zenburn-theme zenburn-theme ample-theme abyss-theme go-autocomplete go-mode go-snippets highlight-numbers highlight-parentheses yasnippet auto-complete ghc chess ess simpleclip cliphist elisp-format cparen cmake-ide company-irony clang-format)))
 '(preview-TeX-style-dir "/home/arnaldur/.emacs.d/elpa/auctex-12.1.1/latex")
 '(preview-scale-function (quote preview-scale-from-face)))
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)

(electric-pair-mode 1)
(electric-layout-mode 1)
(electric-indent-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(highlight-parentheses-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)
(global-linum-mode 1)
(setq-default tab-width 4)
(set-face-attribute 'default nil :font "Inconsolata")
(set-face-attribute 'default nil :height 150)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq x-select-enable-clipboard t)

(load-file "/home/arnaldur/.emacs.d/xclip.el")
(if (not window-system)
	(add-hook 'emacs-startup-hook 'turn-on-xclip))

(if window-system
	(load-theme 'zenburn t))

(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags
	  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
		(js-mode  "<script[^>]*>" "</script>")
		(css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
        )


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-constant-face ((t (:foreground "green"))))
 '(font-lock-type-face ((t (:foreground "PaleGreen" :weight bold))))
 '(julia-macro-face ((t (:foreground "magenta" :slant italic))))
 '(preview-reference-face ((t (:height 2.0)))))
(put 'downcase-region 'disabled nil)


(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
