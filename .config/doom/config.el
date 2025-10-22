(setq user-full-name "Matthew"
      user-mail-address "indetermattrix@gmail.com")

(setq confirm-kill-emacs nil)

(add-to-list 'default-frame-alist '(undecorated . t))

(menu-bar-mode -1)

(setq doom-font (font-spec :family "Hack Nerd Font" :size 18))

(setq doom-unicode-font (font-spec :family "Symbols Nerd Font Mono" :size 18))

(custom-set-faces!
  '(line-number :slant normal :weight normal :family "Hack Nerd Font")
  '(line-number-current-line :slant normal :weight bold :family "Hack Nerd Font"))

(blink-cursor-mode 1)

(setq doom-theme 'doom-moonlight)

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
          "* Summary\n%?\n"
          :target (file+head "books/%<%Y-%m-%d>-${slug}.org"
                             "#+title: ${title}\n#+filetags: :book:\n:PROPERTIES:\n:AUTHOR: %^{Author}\n:PAGES: %^{Pages|0}\n:STARTED: %U\n:FINISHED:\n:RATING: %^{Rating|0|1|2|3|4|5|6|7|8|9|10}\n:STATUS: %^{Status|to-read|reading|finished|abandoned|on-hold}\n:END:\n\n* Notes\n")
          :unnarrowed t)

        ;; Фильмы
        ("mf" "media - Film" plain
          "* Review\n%?\n"
          :target (file+head "media/films/%<%Y-%m-%d>-${slug}.org"
                             "#+title: ${title}\n#+filetags: :media:film:\n:PROPERTIES:\n:YEAR: %^{Year|}\n:RUNTIME: %^{Runtime(min)|}\n:DATE: %U\n:RATING: %^{Rating|0|1|2|3|4|5|6|7|8|9|10}\n:STATUS: %^{Status|watchlist|watching|watched|dropped}\n:END:\n\n* Notes\n")
          :unnarrowed t)
        
        ;; игры
        ("mg" "media - Game" plain
          "* Review\n%?\n"
          :target (file+head "media/games/%<%Y-%m-%d>-${slug}.org"
                             "#+title: ${title}\n#+filetags: :media:game:\n:PROPERTIES:\n:PLATFORM: %^{Platform|PC|PS|Switch|Xbox|Mobile|Other}\n:HOURS: %^{Hours|0}\n:STARTED: %U\n:FINISHED:\n:RATING: %^{Rating|0|1|2|3|4|5|6|7|8|9|10}\n:STATUS: %^{Status|backlog|playing|finished|abandoned}\n:END:\n\n* Notes\n")
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
         :target (file+head "tech-roam/${slug}.org"
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
