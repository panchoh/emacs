;;; init.el --- Emacs’ init -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 pancho horrillo
;;
;; Author: pancho horrillo <pancho@pancho.name>
;; Maintainer: pancho horrillo <pancho@pancho.name>
;; Created: July 07, 2025
;; Modified: July 07, 2025
;; Version: 0.0.1
;; Keywords: init
;; Homepage: https://github.com/panchoh/emacs
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Emacs’ init
;;
;;; Code:

;; https://github.com/progfolio/elpaca/wiki/Usage-with-Nix
(defun my/nixos-p ()
  "Return t if operating system is NixOS, nil otherwise."
  (string-match-p "NixOS" (shell-command-to-string "uname -v")))

;; Run this before the elpaca.el is loaded. Before the installer in your init.el is a good spot.
(when (my/nixos-p) (setq elpaca-core-date '(20250706)))


;; Example Elpaca configuration -*- lexical-binding: t; -*-
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name (concat "builds-" emacs-version) elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                       :ref nil :depth 1 :inherit ignore
                       :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                       :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;; (elpaca example-package)

;; Install use-package support
(elpaca elpaca-use-package
        ;; Enable use-package :ensure support for Elpaca.
        (elpaca-use-package-mode))

;; Block until package is installed/activated so we can use it at the top-level below.
(elpaca-wait)
;; Now we can use the :ensure use-package keyword.
;; You'll want to call `elpaca-wait` after other packages which are required at the top-level of your init.
;; For example, general.el is a popular keybinding library which adds its own use-package keyword.

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil :ensure t :demand t)

;;Turns off elpaca-use-package-mode current declaration
;;Note this will cause evaluate the declaration immediately. It is not deferred.
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil
  :config
  (global-auto-revert-mode 1)
  (auto-save-mode -1)
  (setq auto-save-visited-interval 0)
  (auto-save-visited-mode 1)
  (setq make-backup-files nil)
  (setq visible-bell       1
        ring-bell-function #'ignore))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

(provide 'init)
;;; init.el ends here
