;;; early-init.el --- Emacs’ early init -*- lexical-binding: t; -*-
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
;; Emacs’ early init
;;
;;; Code:

(advice-add #'display-startup-echo-area-message :override #'ignore)

(setq inhibit-startup-screen t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
