(setq user-full-name "Matthew")

(setq confirm-kill-emacs nil)

;;(add-to-list 'default-frame-alist '(undecorated-round t))

(menu-bar-mode -1)

(setq doom-font (font-spec :family "Hack Nerd Font" :size 18))

(setq doom-unicode-font (font-spec :family "Symbols Nerd Font Mono" :size 18))

(custom-set-faces!
  '(line-number :slant normal :weight normal :family "Hack Nerd Font")
  '(line-number-current-line :slant normal :weight bold :family "Hack Nerd Font"))

(blink-cursor-mode 1)

(setq doom-theme 'ef-dark)

;; Отключить нижний разделитель
(setq window-divider-default-bottom-width 0)

(setq display-line-numbers-type 'relative)

(set-language-environment "UTF-8")

(setq org-directory "~/orgfiles/")

(after! org
  (setq org-agenda-files
        '("~/orgfiles/")))
  (setq org-agenda-skip-unavailable-files t)

(after! org
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
   ))

(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "WAIT(w@/!)"
           "HOLD(h@)"
           "READY(r)"
           "|"
           "DONE(d)"
           "CANCELLED(c)")))

  ;; Внешний вид статусов
  (setq org-todo-keyword-faces
        '(("TODO"      . (:foreground "orange red"    :weight bold))
          ("WAIT"      . (:foreground "gold"          :weight bold))
          ("HOLD"      . (:foreground "violet"        :weight bold))
          ("READY"     . (:foreground "deep sky blue" :weight bold))
          ("DONE"      . (:foreground "forest green"  :weight bold))
          ("CANCELLED" . (:foreground "gray"          :weight bold :slant italic)))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/orgfiles/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(beacon-mode 1)

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))
