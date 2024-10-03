;; -*- lexical-binding: t; -*-

(advice-add #'display-startup-echo-area-message :override #'ignore)

(setq inhibit-startup-screen t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
