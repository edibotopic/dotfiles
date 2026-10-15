;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
(setq doom-theme 'nano-dark)

;; `nano-dark' / `nano-light' are the N Λ N O theme variants. Toggle between
;; them with `SPC t n' (bound below), or call `nano-light'/`nano-dark' directly.
(defun +nano/toggle-light-dark ()
  "Toggle between the nano-light and nano-dark themes."
  (interactive)
  (setq doom-theme (if (eq doom-theme 'nano-dark) 'nano-light 'nano-dark))
  (load-theme doom-theme t))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle nano light/dark" "n" #'+nano/toggle-light-dark))

;; Emacs <29 bug: `face-remap-set-base' errors on a single bare face-symbol
;; spec (e.g. `(face-remap-set-base 'header-line 'some-face)`), which is
;; exactly how `nano-modeline' calls it. Fixed upstream in later Emacs;
;; shim it here rather than patching nano-modeline itself.
(when (< emacs-major-version 29)
  (advice-add
   'face-remap-set-base :around
   (lambda (orig-fn face &rest specs)
     (if (and (= (length specs) 1) (symbolp (car specs))
              (car specs) (not (eq (car specs) face)))
         (progn
           (make-local-variable 'face-remapping-alist)
           (let ((entry (assq face face-remapping-alist)))
             (if entry
                 (setcar (cdr entry) (car specs))
               (push (list face (car specs)) face-remapping-alist)))
           (force-mode-line-update))
       (apply orig-fn face specs)))))

;; N Λ N O modeline (replaces Doom's `modeline' module, disabled in init.el)
(use-package! nano-modeline
  :hook ((prog-mode . nano-modeline-prog-mode)
         (text-mode . nano-modeline-text-mode)
         (org-mode  . nano-modeline-org-mode)
         (term-mode . nano-modeline-term-mode)
         (messages-buffer-mode . nano-modeline-message-mode))
  :config
  (nano-modeline-text-mode t)) ; make text-mode's modeline the default/fallback

;; N Λ N O splash/homepage (replaces Doom's `doom-dashboard' module, disabled
;; in init.el). It's intentionally minimal and fades itself out shortly after
;; load, in keeping with the nano philosophy.
(use-package! nano-splash
  :after nano-theme
  :config
  ;; nano-splash.el installs itself on `window-setup-hook' at load time, which
  ;; fires once during startup even in `--fg-daemon' mode (when there's no
  ;; frame yet), hanging the daemon. Remove it and drive the splash from
  ;; frame-creation hooks instead, which works for both daemon and non-daemon.
  (remove-hook 'window-setup-hook #'nano-splash)

  (defun +nano/splash-maybe-h (&optional frame)
    "Show the nano splash on a new frame, unless a file is open."
    (with-selected-frame (or frame (selected-frame))
      (unless (cl-some #'buffer-file-name (buffer-list))
        (nano-splash))))

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'+nano/splash-maybe-h)
    (add-hook 'emacs-startup-hook #'+nano/splash-maybe-h)))

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
