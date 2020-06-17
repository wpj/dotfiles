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

(setq projectile-project-search-path '("~/workspace" "~/workspace/projects" "~/workspace/playground" "~/workspace/tmp"))
(setq projectile-sort-order 'recentf)

;; enable lsp-mode as a backend for company completion in rust files
(after! rust-mode
  (set-company-backend! 'rust-mode 'company-lsp 'company-yasnippet))

(setq
  org-roam-directory "~/workspace/org"
  org-roam-graph-viewer "/Applications/Firefox Developer Edition.app/Contents/MacOS/firefox")


;; deft setup
(setq deft-directory "~/workspace/org")

(add-hook! 'text-mode-hook #'auto-fill-mode)
