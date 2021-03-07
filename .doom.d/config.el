;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Wyatt Johnston"
      user-mail-address "w@wyatt.page")

(setq doom-font (font-spec :family "monospace" :size 16))

(setq doom-theme 'doom-vibrant)

(setq org-directory "~/workspace/org")
(setq org-agenda-files '("~/workspace/org"))

;; (setq display-line-numbers-type 'relative)

;; Write completion time when org tasks are marked done.
(setq org-log-done 'time)

(setq projectile-project-search-path '("~/workspace/projects"))
(setq projectile-sort-order 'recentf)

;; enable lsp-mode as a backend for company completion in rust files
(after! rust-mode
  (set-company-backend! 'rust-mode 'company-lsp 'company-yasnippet))

;; use mspyls
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

(setq
 org-roam-directory "~/workspace/org"
 org-roam-graph-viewer "/Applications/Firefox Developer Edition.app/Contents/MacOS/firefox")

;; Workaround for vs-gutter display issue.
(setq +vc-gutter-default-style nil)

(setq lsp-headerline-breadcrumb-enable nil)

;; deft setup
(setq deft-directory "~/workspace/org")

(add-hook! 'text-mode-hook #'auto-fill-mode)

;; Disable lsp formatting
(setq-hook! '(js2-mode-hook typescript-mode-hook typescript-tsx-mode-hook) +format-with-lsp nil)

;; (setq-hook! 'html-mode-hook +format-with 'prettier)

(set-formatter! 'bean-format "bean-format" :modes '(beancount-mode))

;; (after! (:and lsp-mode flycheck)
;;   (flycheck-add-next-checker 'lsp 'javascript-eslint))


;; (defun js-flycheck-setup ()
;;   (flycheck-add-next-checker 'lsp 'javascript-eslint))

;; (after! (:and lsp-mode flycheck-mode) )

(defun js-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'javascript-eslint))

(add-hook! 'flycheck-mode-hook #'js-flycheck-setup)


;; Don't write to default register when using the system clipboard
;; (setq select-enable-clipboard nil)

(use-package! graphql-mode
  :mode ("\\.gql\\'" "\\.graphql\\'")
  :config (setq-hook! 'graphql-mode-hook tab-width graphql-indent-level))

(use-package! beancount
  :mode ("\\.beancount\\'" . beancount-mode)
  :init
  (after! all-the-icons
    (add-to-list 'all-the-icons-icon-alist
                 '("\\.beancount\\'" all-the-icons-material "attach_money" :face all-the-icons-lblue))
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(beancount-mode all-the-icons-material "attach_money" :face all-the-icons-lblue)))
  :config
  (setq beancount-electric-currency t)
  (defun beancount-bal ()
    "Run bean-report bal."
    (interactive)
    (let ((compilation-read-command nil))
      (beancount--run "bean-report"
                      (file-relative-name buffer-file-name) "bal")))
  (map! :map beancount-mode-map
        :n "TAB" #'beancount-align-to-previous-number
        :i "RET" (cmd! (newline-and-indent) (beancount-align-to-previous-number))))

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
