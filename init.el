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

(use-package emacs
  :config
  (global-auto-revert-mode 1)
  (auto-save-mode -1)
  (setq auto-save-visited-interval 0)
  (auto-save-visited-mode 1)
  (setq make-backup-files nil))


(provide 'init)
;;; init.el ends here
