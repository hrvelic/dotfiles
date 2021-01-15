;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; auto-completion
     ;; better-defaults
     ;; docker
     emacs-lisp
     git
     (ibuffer :variables
              ibuffer-group-buffers-by 'projects)
     markdown
     (org :variables
          org-enable-git-support t
          org-enable-reveal-js-support t)
     racket
     search-engine
     (shell :variables
            shell-default-shell 'term
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-full-span nil)
     shell-scripts
     spell-checking
     syntax-checking
     theming
     version-control
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     (ob-racket :location
                (recipe :fetcher github :repo "DEADB17/ob-racket"))
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((projects . 7)
                                (recents . 20))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 17
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; ORG-MODE
  ;; Enable word wrap in org mode TODO needs fixing
  ;; (add-hook 'org-mode-hook #'(lambda ()
  ;;                              (setq-local word-wrap t)))
  ;;; Should write a toggle function to show descriptive or literate links in Org-mode
  ;;(setq org-descriptive-links nil)

  ;; Define the location of the file to hold tasks
  ;; (setq org-default-notes-file "~/.default_todo.org")

  ;; THEME
  (setq-default
   theming-modifications
   `((spacemacs-dark
      ;; Standard colors
      (default :foreground "#f8e1aa" :background "#1a1a1a" :size 17)
      (font-lock-type-face :foreground "#e95d0b" :weight bold)
      (font-lock-keyword-face :foreground "#e79e3c" :weight bold)
      (font-lock-function-name-face :foreground "#efc090" :weight semi-bold)
      (font-lock-builtin-face :foreground "#b9d62b" :weight bold)
      (font-lock-variable-name-face :foreground "#f8e1aa")
      (font-lock-constant-face :foreground "#f4e048")
      (font-lock-negation-char-face :foreground "#f4e048")
      (font-lock-string-face :foreground "#f4e048" :weight semi-bold)
      (highlight-numbers-number :foreground "#f4e048" :weight semi-bold)
      (font-lock-comment-delimiter-face :foreground "#83786e" :background "#1a1a1a")
      (font-lock-comment-face :foreground "#83786e" :background "#1a1a1a")
      (font-lock-doc-face :foreground "#83786e" :weight semi-bold)
      (font-lock-preprocessor-face :foreground "#dbfffa")
      ;; (error :foreground "#f8e1aa" :bacground "#4e2727"
      ;;        :box (:color "#bc3f3c" :line-width 1))
      ;; Rainbow delimiters
      (rainbow-delimiters-base-face :foreground "#b9d62b")
      ;; Powerline colors
      (mode-line :foreground "#f8e1aa" :background "#413f3c"
                 :box (:color "#7a5d4d" :line-width 1))
      (mode-line-buffer-id :foreground "#e79e3c")
      (mode-line-buffer-id-inactive :foreground "#e79e3c")
      (mode-line-inactive :foreground "#f8e1aa" :background "#2e2b29"
                          :box (:color "#7a5d4d" :line-width 1))
      (powerline-active1 :foreground "#1a1a1a" :background "#eead0e")
      (powerline-active2 :foreground "#1a1a1a" :background "#eead0e")
      (powerline-inactive1 :foreground "#f8e1aa" :background "#262120")
      (powerline-inactive2 :foreground "#f8e1aa" :background "#262120")
      ;; HELM colors

      ;; ORG mode colors
      (org-level-1 :foreground "#e79e3c")
      (org-level-2 :foreground "#e79e3c")
      (org-level-3 :foreground "#e79e3c")
      (org-level-4 :foreground "#e79e3c")
      (org-level-5 :foreground "#e79e3c")
      (org-level-6 :foreground "#e79e3c")
      (org-level-7 :foreground "#e79e3c")
      (org-level-8 :foreground "#e79e3c")
      (org-link :foreground "#efc090")
      (org-document-title :foreground "#efc090")
      (org-document-info-keyword :foreground "#dbfffa" :weight bold)
      (org-document-info :foreground "#dbfffa")
      (org-table :background "#554441")
      (org-column :background "#554441")
      (org-column-title :background "#554441")
      (org-code :foreground "#efc090")
      (org-block :foreground "#f8e1aa" :background "#332f2b")
      (org-block-begin-line :foreground "#83786e" :background "#403730")
      (org-block-end-line :foreground "#83786e" :background "#403730")
      (org-special-keyword :foreground "#e79e3c")
      (hl-todo nil)
      (org-todo :foreground "#b9d62b" :background "#1a1a1a")
      (org-done :foreground "#83786e" :background "#1a1a1a")

      ;; dired colors
      (dired-directory :foreground "#e79e3c")
      (dired-ignored :foreground "#83786e")
      (dired-symlink :foreground "#dbfffa")
      (dired-perm-write :foreground "#f8e1aa")
      )))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; KEY BINDS
  ;; Navigate buffers
  (define-key global-map (kbd "<C-prior>") 'previous-buffer)
  (define-key global-map (kbd "<C-next>") 'next-buffer)

  ;; Define a kanban style set of stages for todo tasks
  (setq org-todo-keywords
        '((sequence "TBD" "IN-PROGRESS" "BLOCKED" "REVIEW" "|" "COMPLETED" "WONTDO")))

  ;; Setting Colours (faces) for todo states to give clearer view of work
  (setq org-todo-keyword-faces
        '(("TBD" . org-todo)
          ("IN-PROGRESS" . "#e95d0b")
          ("BLOCKED" . "red")
          ("REVIEW" . "#f4e048")
          ("COMPLETED" . org-done)
          ("WONTDO" .  org-done)))

  ;; Progress Logging
  ;; When a TBD item enters COMPLETED, add a CLOSED: property with current date-time stamp
  (setq org-log-done 'time)

  ;; MARKDOWN
  ;; Markdown mode hook for orgtbl-mode minor mode
  (add-hook 'markdown-mode-hook 'turn-on-orgtbl)
  ;; org mode: racket literal programming
  (use-package ob-racket
    :after org
    :pin manual
    :config (append `((racket . t) (scribble . t)) org-babel-load-languages))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ob-racket racket-mode faceup yaml-mode xterm-color smeargle shell-pop ox-reveal orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download multi-term mmm-mode markdown-toc markdown-mode magit-gitflow insert-shebang ibuffer-projectile htmlize helm-gitignore helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck fish-mode evil-magit magit transient git-commit with-editor lv eshell-z eshell-prompt-extras esh-help engine-mode dockerfile-mode docker json-mode tablist magit-popup docker-tramp json-snatcher json-reformat diff-hl company-statistics company-shell company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-directory ((t (:foreground "#e79e3c"))))
 '(dired-ignored ((t (:foreground "#83786e"))))
 '(dired-perm-write ((t (:foreground "#f8e1aa"))))
 '(dired-symlink ((t (:foreground "#dbfffa"))))
 '(font-lock-builtin-face ((t (:foreground "#b9d62b" :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#83786e" :background "#1a1a1a"))))
 '(font-lock-comment-face ((t (:foreground "#83786e" :background "#1a1a1a"))))
 '(font-lock-constant-face ((t (:foreground "#f4e048"))))
 '(font-lock-doc-face ((t (:foreground "#83786e" :weight semi-bold))))
 '(font-lock-function-name-face ((t (:foreground "#efc090" :weight semi-bold))))
 '(font-lock-keyword-face ((t (:foreground "#e79e3c" :weight bold))))
 '(font-lock-negation-char-face ((t (:foreground "#f4e048"))))
 '(font-lock-preprocessor-face ((t (:foreground "#dbfffa"))))
 '(font-lock-string-face ((t (:foreground "#f4e048" :weight semi-bold))))
 '(font-lock-type-face ((t (:foreground "#e95d0b" :weight bold))))
 '(font-lock-variable-name-face ((t (:foreground "#f8e1aa"))))
 '(highlight-numbers-number ((t (:foreground "#f4e048" :weight semi-bold))))
 '(mode-line ((t (:foreground "#f8e1aa" :background "#413f3c" :box (:color "#7a5d4d" :line-width 1)))))
 '(mode-line-buffer-id ((t (:foreground "#e79e3c"))))
 '(mode-line-buffer-id-inactive ((t (:foreground "#e79e3c"))))
 '(mode-line-inactive ((t (:foreground "#f8e1aa" :background "#2e2b29" :box (:color "#7a5d4d" :line-width 1)))))
 '(org-block ((t (:foreground "#f8e1aa" :background "#332f2b"))))
 '(org-block-begin-line ((t (:foreground "#83786e" :background "#403730"))))
 '(org-block-end-line ((t (:foreground "#83786e" :background "#403730"))))
 '(org-code ((t (:foreground "#efc090"))))
 '(org-column ((t (:background "#554441"))))
 '(org-column-title ((t (:background "#554441"))))
 '(org-document-info ((t (:foreground "#dbfffa"))))
 '(org-document-info-keyword ((t (:foreground "#dbfffa" :weight bold))))
 '(org-document-title ((t (:foreground "#efc090"))))
 '(org-done ((t (:foreground "#83786e" :background "#1a1a1a"))))
 '(org-level-1 ((t (:foreground "#e79e3c"))))
 '(org-level-2 ((t (:foreground "#e79e3c"))))
 '(org-level-3 ((t (:foreground "#e79e3c"))))
 '(org-level-4 ((t (:foreground "#e79e3c"))))
 '(org-level-5 ((t (:foreground "#e79e3c"))))
 '(org-level-6 ((t (:foreground "#e79e3c"))))
 '(org-level-7 ((t (:foreground "#e79e3c"))))
 '(org-level-8 ((t (:foreground "#e79e3c"))))
 '(org-link ((t (:foreground "#efc090"))))
 '(org-special-keyword ((t (:foreground "#e79e3c"))))
 '(org-table ((t (:background "#554441"))))
 '(org-todo ((t (:foreground "#b9d62b" :background "#1a1a1a"))))
 '(powerline-active1 ((t (:foreground "#1a1a1a" :background "#eead0e"))))
 '(powerline-active2 ((t (:foreground "#1a1a1a" :background "#eead0e"))))
 '(powerline-inactive1 ((t (:foreground "#f8e1aa" :background "#262120"))))
 '(powerline-inactive2 ((t (:foreground "#f8e1aa" :background "#262120"))))
 '(rainbow-delimiters-base-face ((t (:foreground "#b9d62b")))))
