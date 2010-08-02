(require 'font-lock)

(defvar dat-font-lock-keywords
  (list
   (cons "^\\(.*\\)\\(=\\)\\(.*\\)" '((1 font-lock-variable-name-face)
                                      (2 font-lock-builtin-face)
                                      (3 font-lock-constant-face)))
   (cons "<.*?>" font-lock-function-name-face)
   (cons "DONE\\|;" font-lock-builtin-face)
   (cons "\\[.*\\]" font-lock-type-face)
   (cons "^[^!<>;#]*$" font-lock-keyword-face)
   (cons "^\\(<.*?>\\)*\\(.*?\\);" '((2 font-lock-keyword-face)))
   (cons "^#.*" font-lock-comment-face)
   (cons "^\\(Command;\\)*\\(!.*?!\\)" font-lock-function-name-face)
   (cons "\\([!^].*?[!^]\\)" '((1 font-lock-preprocessor-face)))
   (cons "^[^;]*$" font-lock-keyword-face))
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
