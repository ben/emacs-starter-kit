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
(when (and (not (featurep 'aquamacs)) (eq window-system 'mac))
  (progn
    (add-to-list 'default-frame-alist
                 '(font . "-*-andale mono-medium-r-*--10-*-*-*-*-*-mac-roman"))))

(when (featurep 'aquamacs)
  (progn
    (add-to-list 'default-frame-alist
                 '(alpha . (95 70)))
    (define-key global-map [(alt return)] 'mac-toggle-max-window)
    (defun mac-toggle-max-window ()
      "WriteRoom mode; fully opaque, no dock or menubar."
      (interactive)
      (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                               nil
                                             'fullboth))
      (set-frame-parameter nil 'alpha (if (frame-parameter nil 'fullscreen)
                                          '(100 100)
                                        '(95 70))))))
(zenburn)

(provide 'bs-init)