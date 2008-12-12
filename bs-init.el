;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ stuff

;; Wacom styleguide-compliant indentation
(defconst wacom-c-style
  '((c-basic-offset . 3)
    (tab-width . 3)
    (indent-tabs-mode . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((substatement-open before after)
                               (defun-open before after)))
    (c-offsets-alist . ((topmost-intro        . 0)
                        (substatement         . +)
                        (substatement-open    . 0)
                        (case-label           . +)
                        (access-label         . --)
                        (inclass              . +)
                        (inline-open          . 0)
                        (statement-case-open  . 0))))
  "Wacom styleguide indentation style")
(c-add-style "wacom" wacom-c-style)

;; Modified regex for msbuild errors with spaces in the file name
(if (listp 'compilation-error-regexp-alist-alist)
    (add-to-list
     'compilation-error-regexp-alist-alist
     '(msft "^ *\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(]+\\)(\\([0-9]+\\)): \\(?:[a-zA-Z ]*error\\|warnin\\(g\\)\\) C[0-9]+:" 2 3 nil
            (4))))

;; Aesthetics
(when (eq window-system 'w32) 
  (add-to-list 'default-frame-alist
        '(font . "-outline-Consolas-normal-r-normal-normal-12-82-96-96-c-*-iso8859-1")))
(when (eq window-system 'mac) 
  (add-to-list 'default-frame-alist
        '(font . "-*-andale mono-medium-r-*--12-*-*-*-*-*-mac-roman")))
(zenburn)

(provide 'bs-init)