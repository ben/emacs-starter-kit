(require 'font-lock)

(defface wacom-translation-database-delimiter-face
  '((t (:foreground "gold" :strike-through t)))
  "Face for highlighting delimiters." :group nil)
(defvar wacom-translation-database-delimiter-face 'wacom-translation-database-delimiter-face)

(defface wacom-translation-database-wacomese-face
  '((t (:foreground "LightsteelBlue" :underline t)))
  "Face for highlighting Wacomese strings." :group nil)
(defvar wacom-translation-database-wacomese-face 'wacom-translation-database-wacomese-face)

(defvar wacom-translation-database-font-lock-keywords
  (list '("\\(.*\\)\\(\t\\)"
          (2 wacom-translation-database-delimiter-face)
          (1 wacom-translation-database-wacomese-face)))
  "Rules for highlighting Wacom UTF8 translation database files.")

;;;###autoload
(defun wacom-translation-database-mode ()
  "Major mode for editing Wacom UTF8 translation database files."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'wacomtranslation-database-mode
        mode-name "WTD")

  ;; Font locking
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(wacom-translation-database-font-lock-keywords t t nil nil)))

(provide 'wacom-translation-database-mode)