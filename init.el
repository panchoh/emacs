;; -*- lexical-binding: t; -*-

(use-package emacs
  :config
  (global-auto-revert-mode 1)
  (auto-save-mode -1)
  (setq auto-save-visited-interval 0)
  (auto-save-visited-mode 1)
  (setq make-backup-files nil))
