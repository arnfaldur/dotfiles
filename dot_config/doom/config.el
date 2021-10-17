;;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(load! "local")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Arnaldur"
      user-mail-address "a.arnaldur+emacs@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font
      (if (eq system-type 'gnu/linux)
          (font-spec
           :family private-font-family
           :size 16.0
           :weight 'normal
           :width 'normal)))
           ;; :family "Iosevka"
           ;; :family "Fira Code Medium"
           ;; :family "SpaceMono Nerd Font"
      ;; doom-variable-pitch-font
      ;; (font-spec
      ;;  :family "Fira Sans")
      ;; doom-unicode-font
      ;; (font-spec
      ;;  :family "Source Code Pro")
      ;; doom-big-font
      ;; (font-spec
      ;;  :family "Space Mono Nerd Font Complete Mono Windows Compatible"


;; There Are two ways to load a theme. Both assume the theme is installed and
;; available. You Can Either Set `Doom-Theme' Or Manually Load A Theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'sanityinc-tomorrow-bright)
(setq doom-theme 'doom-tomorrow-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Custom options


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq gc-cons-threshold 20000000)
(setq global-undo-tree-mode t)
(setq require-final-newline nil)
(setq confirm-kill-emacs nil)

(setq doom-localleader-key ",")
(map!
 :n "C-+" #'text-scale-increase
 :n "C--" #'text-scale-decrease
 :n "C-M-+" #'doom/increase-font-size
 :n "C-M--" #'doom/decrease-font-size
 :n "C-M-0" #'doom/reset-font-size)

(map! :n "U" 'evil-redo
      :n "S" 'evil-snipe-s
      :v "s" 'evil-surround-region
      :nvm "H" 'evil-first-non-blank
      :nvm "L" 'evil-end-of-line
      (:after evil-easymotion
       :nm "s" evilem-map)
      (:when (featurep! :completion ivy)
       (:after ivy
        :map ivy-minibuffer-map
        "M-RET" #'ivy-immediate-done)))


(after! evil-snipe (evil-snipe-mode -1)
  (setq evil-snipe-scope 'visible))

(let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
      (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic)))

;; (global-activity-watch-mode)

(after! org-journal
  (setq ;; org-journal-file-header "#+TITLE: %Y-%m"
   org-journal-file-type 'monthly
   org-journal-file-format "%Y-%m.org"
   org-journal-dir (concat org-directory "/journal/")
   org-extend-today-until 6
   org-journal-carryover-items nil))

(use-package smerge-mode
  :after hydra
  :config
  (defhydra unpackaged/smerge-hydra
    (:color pink :hint nil :post (smerge-auto-leave))
    "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
    ("n" smerge-next)
    ("p" smerge-prev)
    ("b" smerge-keep-base)
    ("u" smerge-keep-upper)
    ("l" smerge-keep-lower)
    ("a" smerge-keep-all)
    ("RET" smerge-keep-current)
    ("\C-m" smerge-keep-current)
    ("<" smerge-diff-base-upper)
    ("=" smerge-diff-upper-lower)
    (">" smerge-diff-base-lower)
    ("R" smerge-refine)
    ("E" smerge-ediff)
    ("C" smerge-combine-with-next)
    ("r" smerge-resolve)
    ("k" smerge-kill-current)
    ("ZZ" (lambda ()
            (interactive)
            (save-buffer)
            (bury-buffer))
     "Save and bury buffer" :color blue)
    ("q" nil "cancel" :color blue))
  :hook (magit-diff-visit-file . (lambda ()
                                   (when smerge-mode
                                     (unpackaged/smerge-hydra/body)))))

;; (map! :i "C-i" #'flyspell-auto-correct-word) WHAT!?
(map! :map doom-leader-code-map
      "c" #'recompile
      "C" #'compile)


(defun latex/build ()
  (interactive)
  (progn
    (let ((TeX-save-query nil))
      (TeX-save-document (TeX-master-file)))
    (TeX-command "LatexMk" 'TeX-master-file -1)))

(after! latex
  (map!
   :after latex
   :map LaTeX-mode-map
   :localleader
   :desc "Build" "b" 'latex/build
   :desc "View" "v" 'TeX-view
   :desc "Make environment" "e" 'cdlatex-environment))


;; (map!
;;  :map TeX-fold-mode-map
;;  :localleader
;;  :desc "Fold paragraph"   "f"   #'TeX-fold-paragraph
;;  :desc "Unfold paragraph" "F"   #'TeX-fold-clearout-paragraph
;;  :desc "Unfold buffer"    "C-f" #'TeX-fold-clearout-buffer)

(after! lsp-clangd
  (set-lsp-priority! 'clangd 2)
  (setq lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--header-insertion=never")))

(after! bison
  (setq bison-decl-token-column 4)
  (setq bison-decl-type-column 4)
  (setq bison-rule-enumeration-column 4)
  (setq bison-rule-separator-column 4))

