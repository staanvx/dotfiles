(setq user-full-name "Matthew"
      user-mail-address "indetermattrix@gmail.com")

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

(setq org-directory       "~/orgfiles/"
      org-roam-directory  "~/orgfiles/")

(org-roam-db-autosync-mode 1)

(setq org-agenda-files
      (append (directory-files-recursively
               (expand-file-name "tasks" org-roam-directory) "\\.org$")
              (list (expand-file-name "inbox.org" org-roam-directory)
                    (expand-file-name "calendar/calendar.org" org-roam-directory))))

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

(use-package! org-roam
  :custom
  (org-roam-completion-everywhere t)
  :config
  (setq org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:20}" 'face 'org-tag))))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq org-capture-templates
        ;; инбокс
      '(("i" "Inbox" entry (file "~/orgfiles/inbox.org")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n")
        ;; задачи
        ("t" "Task" entry (file "~/orgfiles/tasks/tasks.org")
         "* TODO %?\nSCHEDULED: %^t\n:PROPERTIES:\n:CREATED: %U\n:CONTEXT: %^{context|dev|study|life|work}\n:END:\n")
        ;; события
        ("e" "Event" entry (file "~/orgfiles/calendar/calendar.org")
         "* %? \n<%^t>\n:PROPERTIES:\n:LOCATION: %^{location}\n:END:\n")))

(setq org-roam-capture-templates
      '(
        ;; Общие заметки
        ("n" "Note" plain "%?"
         :target (file+head "notes/${slug}.org"
                            "#+title: ${title}\n#+filetags: :note:\n")
         :unnarrowed t)

        ;; Книги
        ("b" "Book" plain
         "* Summary\n%?\n* Цитаты\n"
         :target (file+head "books/${slug}.org"
                            "#+title: ${title}\n#+filetags: :book:\n")
         :unnarrowed t)

        ;; Фильмы
        ("mf" "media - Film" plain
         "* Review\n%?\n"
         :target (file+head "media/films/${slug}.org"
                            "#+title: ${title}\n#+filetags: :media:film:\n")
         :unnarrowed t)

        ;; игры
        ("mg" "media - game" plain
         "* review\n%?\n"
         :target (file+head "media/games/${slug}.org"
                            "#+title: ${title}\n#+filetags: :media:game:\n")
         :unnarrowed t)

        ;; музыка
        ("mm" "media - music" plain
         "* review\n%?\n"
         :target (file+head "media/music/${slug}.org"
                            "#+title: ${title}\n#+filetags: :media:music:\n")
         :unnarrowed t)
        
        ;; Технические заметки
        ("t" "Tech note" plain
         "* Context\n%?\n"
         :target (file+head "tech/${slug}.org"
                            "#+title: ${title}\n#+filetags: :tech:\n")
         :unnarrowed t)
        ))

;; улучшение интерфейса для заметок
(use-package! org-modern :hook (org-mode . org-modern-mode))

;; удобное сохранение изображений
(use-package! org-download
  :after org
  :config
  (setq org-download-method 'attach
        org-download-image-dir "images"
        org-download-heading-lvl 0))

;; удобное вставка ссылок
(use-package! org-cliplink :after org)

;; улучшенное отображение agenda
(use-package! org-super-agenda
  :after org-agenda
  :config (org-super-agenda-mode 1))

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
