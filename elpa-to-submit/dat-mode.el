(require 'font-lock)

(defvar dat-font-lock-keywords
  (list
   (cons "^#.*" font-lock-comment-face)
   (cons "\\[.*\\]\\|.*DONE$" font-lock-function-name-face)
   (cons "^.*?=\\([0-9]+;\\)?" font-lock-doc-face)
   (list "^\\(.*?=\\([0-9]+;\\)?\\)\\([a-zA-Z0-9.\_]*?\\);"
         '(1 font-lock-doc-face)
         '(3 font-lock-string-face))
   (cons "[!^].*?[!^]" font-lock-variable-name-face)
   (cons ";" font-lock-keyword-face))
  "Rules for highlighting Wacom-style installer DAT files.")

;;;###autoload
(defun dat-mode ()
  "Major mode for editing Wacom DAT files."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'dat-mode
        mode-name "DAT")

  ; Font-locking
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(dat-font-lock-keywords t t nil nil)))

(provide 'dat-mode)