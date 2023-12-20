;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Shane Crowley"
      user-mail-address "edibotopic@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant) ;; default
;; (load-theme 'creamsody-darker t) ;; nice dark
;; (load-theme 'naysayer t) ;; nice mid
;; (load-theme 'spacemacs-light t) ;; nice light

;; (setq fancy-splash-image "~/Pictures/tree.png")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Notes_vault/00-09-Meta/06-Org/")

;; Define the location of the file to hold tasks and notes
(setq org-default-notes-file "~/Dropbox/Notes_vault/00-09-Meta/06-Org/06.04-notes.org")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; global beacon minor-mode
;; (use-package! beacon)
;; (after! beacon (beacon-mode 1))

;; (add-to-list 'default-frame-alist '(alpha . 95)) BUG: not working

;; Org-mode

;; (org-indent
;;    (:inherit org-hide)
;;    (:inherit (org-hide fixed-pitch)))

(setq org-startup-indented t
      org-bullets-bullet-list '(" ")
      org-ellipsis "  "
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)

(org-babel-do-load-languages 'org-babel-load-languages '((python . t) (jupyter . t) (ipython . t) (julia . t)))

(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "-i --simple-prompt")

(after! (org org-capture)
  (add-to-list 'org-capture-templates
        '("c" "Checklist"  entry
        (file+headline "~/Dropbox/Notes_vault/00-09-Meta/06-Org/06.00-checklist.org" "Checklist")
        "* [ ] %? %T" :empty-lines 1)

  (add-to-list 'org-capture-templates
        '("f" "Fragment"  entry
        (file+headline "~/Dropbox/Notes_vault/00-09-Meta/06-Org/06.01-fragments.org" "Fragments")
        "* %? %T" :empty-lines 1)

  (add-to-list 'org-capture-templates
        '("d" "Diary"  entry
        (file+headline "~/Dropbox/Notes_vault/00-09-Meta/06-Org/06.02-diary.org" "Diary")
        "* %? %T" :empty-lines 1)

  (add-to-list 'org-capture-templates
        '("i" "Idea"  entry
        (file+headline "~/Dropbox/Notes_vault/00-09-Meta/06-Org/06.03-ideas.org" "Ideas")
        "* %? %T" :empty-lines 1))))))

;; Config org-agenda calendar for integrations
(setq org-icalendar-timezone "Europe/Dublin")

(defun export-org-to-ics ()
  "Export Org agenda file to ICS format."
  (let ((org-file (buffer-file-name)))
    (when (and org-file
               (string-suffix-p ".org" org-file)
               (string-prefix-p "/home/edibotopic/Dropbox/Notes_vault/00-09-Meta/06-Org/agenda/" org-file))
      (let* ((base-dir (file-name-directory org-file))
             (export-dir (concat base-dir "export/"))
             (file-name-no-ext (file-name-sans-extension (file-name-nondirectory org-file)))
             (ics-file (concat export-dir file-name-no-ext ".ics")))
        (make-directory export-dir t) ; Create export directory if it doesn't exist
        (org-export-to-file 'icalendar ics-file)))))

(add-hook 'after-save-hook 'export-org-to-ics)

(setq geiser-chicken-binary "/usr/bin/csi")
