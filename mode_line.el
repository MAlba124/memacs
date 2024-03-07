(require 'all-the-icons)
(require 'evil)

(defface memacs-modeline-evil-mode-face
  '((t (:foreground "#f0f1ff" :background "#093060"))) "Evil mode")

(defface memacs-modeline-buffer-face
  '((t (:foreground "#0a0a0a" :background "#d0d6ff"))) "Buffer")

(setq-default mode-line-format
      '("%e"
        (:eval
         (when (mode-line-window-selected-p)
           (propertize (format "%s%s"
            evil-mode-line-tag
            " "
            ) 'face 'memacs-modeline-evil-mode-face)))
        memacs-modeline-buffer-name
        (:eval
         (when (mode-line-window-selected-p)
           (format "   %s   %s"
                   "%l:%c"
            (capitalize (symbol-name major-mode)))
        ))))

(defvar-local memacs-modeline-buffer-name
    '(:eval (propertize (format " %s %s "
                    (all-the-icons-icon-for-file (buffer-name))
                    (buffer-name)) 'face 'memacs-modeline-buffer-face)))

(put 'memacs-modeline-buffer-name 'risky-local-variable t)
