;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Wyatt Johnston"
      user-mail-address "w@wyatt.page")

(setq doom-font (font-spec :family "monospace" :size 16))

(setq doom-theme 'doom-one)

(setq org-directory "~/workspace/org")
(setq org-agenda-files '("~/workspace/org"))

(setq display-line-numbers-type 'relative)

;; Write completion time when org tasks are marked done.
(setq org-log-done 'time)

(setq projectile-project-search-path '("~/workspace/projects"))
(setq projectile-sort-order 'recentf)
;; Open magit status buffer when switching projects.
(setq +workspaces-switch-project-function #'magit-status)

;; enable lsp-mode as a backend for company completion in rust files
(after! rust-mode
  (set-company-backend! 'rust-mode 'company-lsp 'company-yasnippet))

(setq
 org-roam-directory "~/workspace/org"
 org-roam-graph-viewer "/Applications/Firefox Developer Edition.app/Contents/MacOS/firefox")


;; deft setup
(setq deft-directory "~/workspace/org")

(add-hook! 'text-mode-hook #'auto-fill-mode)

;; Disable lsp formatting
(setq-hook! '(js2-mode-hook typescript-mode-hook) +format-with-lsp nil)

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
