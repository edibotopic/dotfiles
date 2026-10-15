;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Avoid the "Loading a theme can run Lisp code. Really load?" y-or-n-p
;; prompt. This hangs/crashes `--fg-daemon' boot (no TTY to answer it), which
;; is how auto-dark/doom-nano-themes load at startup below.
(setq custom-safe-themes t)

;; Fish is your $SHELL on Linux/macOS, which can inject garbage output into
;; child processes Emacs spawns (compile, vterm, lsp, etc). Force a POSIX
;; shell for those. Not applicable on Windows (no fish, no bash by default).
(when (and (not IS-WINDOWS) (executable-find "bash"))
  (setq shell-file-name (executable-find "bash")))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Roboto Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 14)
      doom-serif-font (font-spec :family "Roboto Slab" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nano-dark)

;; doom-nano-themes isn't a doom-themes-dir package, so load-theme can't find
;; it via the normal theme search path — register its build dir explicitly.
(when-let (path (locate-library "doom-nano-dark-theme"))
  (add-to-list 'custom-theme-load-path (file-name-directory path)))

;; Toggle between N Λ N O light/dark variants (built on doom-themes, so no
;; custom modeline/splash machinery involved — avoids the Emacs 28.1
;; face-remap-set-base bug hit by the real nano-modeline/nano-splash).
(defun +nano/toggle-light-dark ()
  "Toggle between doom-nano-light and doom-nano-dark."
  (interactive)
  (let ((new-theme (if (memq 'doom-nano-dark custom-enabled-themes)
                        'doom-nano-light
                      'doom-nano-dark)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme new-theme t)
    (setq doom-theme new-theme)))
(map! :leader "t n" #'+nano/toggle-light-dark)

;; Follow Ubuntu/GNOME's light/dark appearance setting automatically.
;; auto-dark-themes is (DARK-THEMES LIGHT-THEMES), not auto-dark-light-theme/
;; auto-dark-dark-theme (those don't exist in this package version).
(use-package! auto-dark
  :init
  (setq auto-dark-themes '((doom-nano-dark) (doom-nano-light)))
  :config
  (auto-dark-mode 1))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
