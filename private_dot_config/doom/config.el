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

;; `ispell-personal-dictionary' lives under a gitignored cache dir (not
;; chezmoi-tracked), so it won't exist on a fresh machine. aspell silently
;; fails to save words you accept via `+spell/correct'/`ispell-word' if this
;; directory is missing — the squiggle just comes back with no error. Doom's
;; `spell' module only sets this variable lazily once `ispell' is actually
;; loaded, so we hook the same way rather than checking it at startup.
(after! ispell
  (when ispell-personal-dictionary
    (make-directory (file-name-directory ispell-personal-dictionary) t)))

;; Sensible opening window size (default is tall/narrow). Sized as a
;; percentage of the frame's actual monitor geometry (not fixed columns/rows),
;; so it looks right on a small laptop screen, an external 4K monitor, or
;; anything in between, and is centered on whichever monitor the frame opens
;; on. Applies to every new frame, including the first one the daemon creates
;; for emacsclient.
(defun +nano/size-frame-to-monitor (&optional frame)
  (when-let* ((frame (or frame (selected-frame)))
              (workarea (and (display-graphic-p frame)
                              (frame-monitor-attribute 'workarea frame))))
    (let* ((mx (nth 0 workarea)) (my (nth 1 workarea))
           (mw (nth 2 workarea)) (mh (nth 3 workarea))
           (width (round (* mw 0.7)))
           (height (round (* mh 0.8)))
           (x (+ mx (round (/ (- mw width) 2))))
           (y (+ my (round (/ (- mh height) 2)))))
      (set-frame-size frame width height t)
      (set-frame-position frame x y))))
(defun +nano/size-frame-to-monitor-deferred (&optional frame)
  "Resize FRAME after a short delay.
`frame-monitor-attribute' can report stale/incomplete geometry immediately at
frame-creation time, before the window manager/compositor has finished
placing the frame, so we give it a moment to settle first."
  (run-at-time 0.1 nil #'+nano/size-frame-to-monitor (or frame (selected-frame))))
(add-hook 'window-setup-hook #'+nano/size-frame-to-monitor-deferred)
(add-hook 'server-after-make-frame-hook #'+nano/size-frame-to-monitor-deferred)


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
      doom-serif-font (font-spec :family "Roboto Slab" :size 14)
      ;; Without this, bullet/symbol glyphs (e.g. org-superstar's ●/○) fall
      ;; back to whichever system font has them, which often has mismatched
      ;; metrics and renders as warped/squished ellipses instead of circles.
      doom-symbol-font (font-spec :family "DejaVu Sans Mono" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'creamsody-darker)

;; creamsody-theme isn't a doom-themes-dir package, so load-theme can't find
;; it via the normal theme search path — register its build dir explicitly.
(when-let (path (locate-library "creamsody-darker-theme"))
  (add-to-list 'custom-theme-load-path (file-name-directory path)))

;; Toggle between the dark (creamsody-darker) and light (doom-opera-light,
;; part of doom-themes) variants.
(defun +nano/toggle-light-dark ()
  "Toggle between doom-opera-light and creamsody-darker."
  (interactive)
  (let ((new-theme (if (memq 'creamsody-darker custom-enabled-themes)
                        'doom-opera-light
                      'creamsody-darker)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme new-theme t)
    (setq doom-theme new-theme)))
(map! :leader "t n" #'+nano/toggle-light-dark)

;; Follow Ubuntu/GNOME's light/dark appearance setting automatically.
;; auto-dark-themes is (DARK-THEMES LIGHT-THEMES), not auto-dark-light-theme/
;; auto-dark-dark-theme (those don't exist in this package version).
(use-package! auto-dark
  :init
  (setq auto-dark-themes '((creamsody-darker) (doom-opera-light)))
  :config
  ;; Doom's `doom-init-theme-h' re-applies the `doom-theme' variable on every
  ;; new frame (incl. each emacsclient window) via `server-after-make-frame-hook'.
  ;; auto-dark only flips the *active* theme, not that variable, so without
  ;; this it silently reverts to the stale default on the next frame. These
  ;; hooks must be registered BEFORE `auto-dark-mode' is enabled below, since
  ;; enabling it immediately runs the initial check-and-set synchronously.
  (add-hook 'auto-dark-dark-mode-hook
            (lambda () (setq doom-theme 'creamsody-darker)))
  (add-hook 'auto-dark-light-mode-hook
            (lambda () (setq doom-theme 'doom-opera-light)))
  (auto-dark-mode 1))

;; DragonRuby/drenv language server (needs drenv >= 0.17.0 on PATH).
;; Dormant outside DragonRuby projects, so safe to activate on all Ruby.
(after! lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("drenv" "lsp"))
    :activation-fn (lsp-activate-on "ruby")
    :priority -1
    :server-id 'drenv)))
(add-hook 'ruby-mode-hook #'lsp-deferred)

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
