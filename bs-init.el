;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ stuff

;; map .h to C++ mode
(add-to-list 'auto-mode-alist
             '("\\.h$" . c++-mode))

;; C-c C-m -> compile
(defun compile-using-default-cmd ()
  (interactive)
  (compile compile-command))
(defun my-c-mode-common-hook ()
  (define-key c++-mode-map (kbd "C-c C-m") 'compile-using-default-cmd))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-mode entries
;; Translation databases
(add-to-list 'auto-mode-alist '("\\.utf8$" . wacom-translation-database-mode))
(add-to-list 'auto-mode-alist '("\\.dat$" . dat-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.bat$" . batch-mode))
(add-to-list 'auto-mode-alist '("\\.cmd$" . batch-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aesthetics
(scroll-bar-mode nil)
(when (eq window-system 'w32)
  (progn
    (add-to-list 'default-frame-alist
                 '(font . "-outline-Consolas-normal-r-normal-normal-14-82-96-96-c-*-iso8859-1"))
    ;; (add-to-list 'default-frame-alist
    ;;              '(alpha . (95 90)))
    ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mac Emacs doesn't auto-start server-mode
(server-mode 1)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Colors. Blackboard is unusable in a putty window.
(require 'color-theme)
(if (display-graphic-p)
    (progn
      (require 'color-theme-tangotango)
      (color-theme-tangotango)
      ;(color-theme-blackboard)
      )
  (color-theme-zenburn))

;; Revert-buffer shortcut
(defun bs-revert-buffer () (interactive) (revert-buffer t t))
(global-set-key [C-f12] 'bs-revert-buffer)

;; AucTeX init
(if (load "auctex.el" t t t)
    (progn
      (load "preview-latex.el" nil t t)
      (require 'tex-mik)
      (eval-after-load 'info
        '(add-to-list 'Info-directory-list "c:/Program Files/Emacs/share/info"))
      (setq TeX-auto-save t)
      (setq TeX-parse-self t)))


;; Fullscreen, only works on OSX
(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen)
                           nil
                         'fullboth)))

(when (featurep 'ns-win)
  (progn
    (add-to-list 'default-frame-alist
                 '(alpha . (95 90)))
    (define-key global-map [(alt return)] 'mac-toggle-max-window)))

;; Scroll behavior tweaking, inspired by
;; http://emacs-fu.blogspot.com/2009/12/scrolling.html
(setq
 scroll-margin 5
 scroll-conservatively 10000
 scroll-preserve-screen-position 1)

;; Cursor shape/color to reflect read/write status. Shamelessly stolen from
;; http://emacs-fu.blogspot.com/2009/12/changing-cursor-color-and-shape.html
(setq djcb-read-only-color       "gray")
(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "yellow")
(setq djcb-normal-cursor-type    'bar)
(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
   (buffer-read-only
    (set-cursor-color djcb-read-only-color)
    (setq cursor-type djcb-read-only-cursor-type))
   (overwrite-mode
    (set-cursor-color djcb-overwrite-color)
    (setq cursor-type djcb-overwrite-cursor-type))
   (t 
    (set-cursor-color djcb-normal-color)
    (setq cursor-type djcb-normal-cursor-type))))
(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

;; Ibuffer grouping
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"      
               ("Org" ;; all org-related buffers
                (mode . org-mode))  
               ("Wacom Source"
                (filename . "C:/src"))
               ("Programming" ;; prog stuff not already in MyProjectX
                (or
                 (mode . c-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)
                 ;; etc
                 )) 
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))



;;; Kill-ring popup-menu
(global-set-key "\C-cy" '(lambda ()
                           (interactive)
                           (popup-menu 'yank-menu)))


(provide 'bs-init)
