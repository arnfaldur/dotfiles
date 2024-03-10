(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-clean-confirm nil)
 '(ansi-color-names-vector
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(apheleia-formatters
   '((astyle "astyle"
      (apheleia-formatters-locate-file "--options" ".astylerc"))
     (asmfmt "asmfmt")
     (bean-format "bean-format")
     (beautysh "beautysh"
      (apheleia-formatters-indent "--tab" "--indent-size" 'sh-basic-offset)
      "-")
     (black "black"
      (when
          (apheleia-formatters-extension-p "pyi")
        "--pyi")
      (apheleia-formatters-fill-column "--line-length")
      "-")
     (brittany "brittany")
     (buildifier "buildifier")
     (caddyfmt "caddy" "fmt" "-")
     (clang-format "clang-format" "-assume-filename"
      (or
       (apheleia-formatters-local-buffer-file-name)
       (apheleia-formatters-mode-extension)
       ".c"))
     (cmake-format "cmake-format" "-")
     (crystal-tool-format "crystal" "tool" "format" "-")
     (css-beautify "css-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (dart-format "dart" "format")
     (denofmt "deno" "fmt" "-")
     (denofmt-js "deno" "fmt" "-" "--ext" "js")
     (denofmt-json "deno" "fmt" "-" "--ext" "json")
     (denofmt-jsonc "deno" "fmt" "-" "--ext" "jsonc")
     (denofmt-jsx "deno" "fmt" "-" "--ext" "jsx")
     (denofmt-md "deno" "fmt" "-" "--ext" "md")
     (denofmt-ts "deno" "fmt" "-" "--ext" "ts")
     (denofmt-tsx "deno" "fmt" "-" "--ext" "tsx")
     (elm-format "elm-format" "--yes" "--stdin")
     (fish-indent "fish_indent")
     (fourmolu "fourmolu")
     (gawk "gawk" "-f" "-" "--pretty-print=-")
     (gofmt "gofmt")
     (gofumpt "gofumpt")
     (goimports "goimports")
     (google-java-format "google-java-format" "-")
     (hclfmt "hclfmt")
     (html-beautify "html-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (html-tidy "tidy" "--quiet" "yes" "--tidy-mark" "no" "--vertical-space" "yes" "-indent"
      (when
          (derived-mode-p 'nxml-mode)
        "-xml")
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-spaces")
      (apheleia-formatters-fill-column "-wrap"))
     (isort "isort" "-")
     (js-beautify "js-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (jq "jq" "." "-M"
      (apheleia-formatters-indent "--tab" "--indent"))
     (lisp-indent . apheleia-indent-lisp-buffer)
     (ktlint "ktlint" "--log-level=none" "--stdin" "-F" "-")
     (latexindent "latexindent" "--logfile=/dev/null")
     (mix-format "apheleia-mix" "format" "-")
     (nixfmt "nixfmt")
     (ocamlformat "ocamlformat" "-" "--name" filepath "--enable-outside-detected-project")
     (ormolu "ormolu")
     (perltidy "perltidy" "--quiet" "--standard-error-output"
      (apheleia-formatters-indent "-t" "-i")
      (apheleia-formatters-fill-column "-l"))
     (pgformatter "pg_format"
      (apheleia-formatters-indent "--tabs" "--spaces" 'tab-width)
      (apheleia-formatters-fill-column "--wrap-limit"))
     (phpcs "apheleia-phpcs")
     (prettier "prettier" "--stdin-filepath" filepath)
     (prettier-css "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=css"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-html "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=html"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-graphql "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=graphql"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-javascript "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=babel-flow"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-json "prettier" "--stdin-filepath" filepath "--parser=json")
     (prettier-markdown "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=markdown"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-ruby "apheleia-npx" "prettier" "--stdin-filepath" filepath "--plugin=@prettier/plugin-ruby" "--parser=ruby"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-scss "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=scss"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-svelte "apheleia-npx" "prettier" "--stdin-filepath" filepath "--plugin=prettier-plugin-svelte" "--parser=svelte"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-typescript "prettier" "--stdin-filepath" filepath "--parser=typescript")
     (prettier-yaml "prettier" "--stdin-filepath" filepath "--parser=yaml")
     (purs-tidy "apheleia-npx" "purs-tidy" "format")
     (robotidy "robotidy" "--no-color" "-"
      (apheleia-formatters-indent nil "--indent")
      (apheleia-formatters-fill-column "--line-length"))
     (rubocop "rubocop" "--stdin" filepath "--auto-correct" "--stderr" "--format" "quiet" "--fail-level" "fatal")
     (ruby-standard "standardrb" "--stdin" filepath "--fix" "--stderr" "--format" "quiet" "--fail-level" "fatal")
     (ruff "ruff" "format" "--silent"
      (apheleia-formatters-fill-column "--line-length")
      "--stdin-filename" filepath "-")
     (shfmt "shfmt" "-filename" filepath "-ln"
      (cl-case
          (bound-and-true-p sh-shell)
        (sh "posix")
        (t "bash"))
      (when apheleia-formatters-respect-indent-level
        (list "-i"
              (number-to-string
               (cond
                (indent-tabs-mode 0)
                ((boundp 'sh-basic-offset)
                 sh-basic-offset)
                (t 4)))))
      "-")
     (rufo "rufo" "--filename" filepath "--simple-exit")
     (stylua "stylua" "-")
     (rustfmt "rustfmt" "--edition" "2021" "--quiet" "--emit" "stdout")
     (terraform "terraform" "fmt" "-")
     (xmllint "xmllint" "--format" "-")
     (yapf "yapf")
     (yq-csv "yq" "--prettyPrint" "--no-colors" "--input-format" "csv" "--output-format" "csv")
     (yq-json "yq" "--prettyPrint" "--no-colors" "--input-format" "json" "--output-format" "json")
     (yq-properties "yq" "--prettyPrint" "--no-colors" "--input-format" "props" "--output-format" "props")
     (yq-tsv "yq" "--prettyPrint" "--no-colors" "--input-format" "tsv" "--output-format" "tsv")
     (yq-xml "yq" "--prettyPrint" "--no-colors" "--input-format" "xml" "--output-format" "xml")
     (yq-yaml "yq" "--prettyPrint" "--no-colors" "--no-doc" "--input-format" "yaml" "--output-format" "yaml")))
 '(custom-safe-themes
   '("2b3f1e6abe0f02ff73d95dca04901bdbc2ecebe80fa453eded34fa39c8b050cb" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" default))
 '(evil-move-beyond-eol t)
 '(evil-snipe-scope 'visible)
 '(exwm-floating-border-color "#504945")
 '(fci-rule-color "#7c6f64")
 '(geiser-active-implementations '(chez) t)
 '(geiser-chez-binary "chezscheme")
 '(highlight-tail-colors ((("#363627" "#363627") . 0) (("#323730" "#323730") . 20)))
 '(httpd-port 8070)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d1011" "#fabd2f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d1011" "#b8bb26"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d1011" "#928374"))
 '(js-indent-level 2)
 '(lsp-file-watch-threshold nil)
 '(magit-gitflow-hotfix-finish-arguments '("--notag"))
 '(magit-gitflow-release-finish-arguments '("--notag"))
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(midnight-mode t)
 '(objed-cursor-color "#fb4934")
 '(org-log-done 'time)
 '(pdf-view-midnight-colors (cons "#ebdbb2" "#282828"))
 '(python-pytest-executable "venv/bin/pytest")
 '(python-shell-interpreter "ipython")
 '(python-shell-interpreter-args "--simple-prompt")
 '(require-final-newline nil)
 '(rustic-ansi-faces
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(safe-local-variable-values '((checkdoc-package-keywords-flag)))
 '(scheme-program-name "chezscheme")
 '(smerge-command-prefix "SPC g m")
 '(tab-width 4)
 '(tree-sitter-major-mode-language-alist
   '((agda2-mode . agda)
     (sh-mode . bash)
     (c-mode . c)
     (caml-mode . ocaml)
     (clojure-mode . clojure)
     (csharp-mode . c-sharp)
     (c++-mode . cpp)
     (d-mode . d)
     (css-mode . css)
     (elm-mode . elm)
     (elixir-mode . elixir)
     (erlang-mode . erlang)
     (ess-r-mode . r)
     (fennel-mode . fennel)
     (go-mode . go)
     (haskell-mode . haskell)
     (hcl-mode . hcl)
     (terraform-mode . hcl)
     (html-mode . html)
     (markdown-mode . markdown)
     (mhtml-mode . html)
     (nix-mode . nix)
     (java-mode . java)
     (javascript-mode . javascript)
     (js-mode . javascript)
     (js2-mode . javascript)
     (js3-mode . javascript)
     (json-mode . json)
     (jsonc-mode . json)
     (julia-mode . julia)
     (lua-mode . lua)
     (matlab-mode . matlab)
     (meson-mode . meson)
     (ocaml-mode . ocaml)
     (perl-mode . perl)
     (php-mode . php)
     (prisma-mode . prisma)
     (python-mode . python)
     (pygn-mode . pgn)
     (rjsx-mode . javascript)
     (ruby-mode . ruby)
     (rust-mode . rust)
     (rustic-mode . rust)
     (scala-mode . scala)
     (scheme-mode . scheme)
     (svelte-mode . svelte)
     (swift-mode . swift)
     (toml-mode . toml)
     (tuareg-mode . ocaml)
     (typescript-mode . typescript)
     (verilog-mode . verilog)
     (yaml-mode . yaml)
     (zig-mode . zig)))
 '(vc-annotate-background "#282828")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b8bb26")
    (cons 40 "#cebb29")
    (cons 60 "#e3bc2c")
    (cons 80 "#fabd2f")
    (cons 100 "#fba827")
    (cons 120 "#fc9420")
    (cons 140 "#fe8019")
    (cons 160 "#ed611a")
    (cons 180 "#dc421b")
    (cons 200 "#cc241d")
    (cons 220 "#db3024")
    (cons 240 "#eb3c2c")
    (cons 260 "#fb4934")
    (cons 280 "#e05744")
    (cons 300 "#c66554")
    (cons 320 "#ac7464")
    (cons 340 "#7c6f64")
    (cons 360 "#7c6f64")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground unspecified :box nil :inherit font-lock-comment-face :weight light)))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
