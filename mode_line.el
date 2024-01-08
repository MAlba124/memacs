(require 'all-the-icons)
(require 'evil)

(setq-default mode-line-format
      '("%e"
        (:eval
         (when (mode-line-window-selected-p)
           (format "%s%s"
            evil-mode-line-tag
            "| "
            )))
        memacs-modeline-buffer-name
        (:eval
         (when (mode-line-window-selected-p)
           (format " | %s %s | %s"
                   (all-the-icons-faicon "location-arrow")
                   "%l:%c"
            (capitalize (symbol-name major-mode)))
        ))))

(defvar-local memacs-modeline-buffer-name
    '(:eval (format "%s %s"
                    (all-the-icons-icon-for-file (buffer-name))
                    (buffer-name))))

(put 'memacs-modeline-buffer-name 'risky-local-variable t)
