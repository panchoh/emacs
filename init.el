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

(push (expand-file-name "lisp/" user-emacs-directory)
      load-path)

(require 'elpaca-installer)

;; Block until package is installed/activated so we can use it at the top-level below.
(elpaca-wait)
;; Now we can use the :ensure use-package keyword.
;; You'll want to call `elpaca-wait` after other packages which are required at the top-level of your init.
;; For example, general.el is a popular keybinding library which adds its own use-package keyword.

;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
(use-package general
  :ensure (:wait t)
  :demand t)

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
