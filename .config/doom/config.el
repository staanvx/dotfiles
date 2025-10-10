(setq user-full-name "Matthew"
      user-mail-address "indetermattrix@gmail.com")

;; Настройка расположения и размера окна при запуске
;;(setq initial-frame-alist
  ;;    '((width . 120)
    ;;    (height . 40)
      ;;  (left . 50)
        ;;(top . 50)))

;; Выключение подтверждения выхода из emacs
(setq confirm-kill-emacs nil)

;;(add-to-list 'default-frame-alist '(undecorated-round t))

(menu-bar-mode -1)

(setq fancy-splash-image "~/.config/assets/smaller-shark2.png")

;; Установка основного шрифта
(setq doom-font (font-spec :family "Hack Nerd Font" :size 18))

;; Установка шрифта для пропорционального текста
(setq doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 18))

;; Установка шрифта для символов Unicode
;;(setq doom-unicode-font (font-spec :family "Hack Nerd Font" :size 18))

(setq doom-unicode-font (font-spec :family "Symbols Nerd Font Mono" :size 18))

;; Номера строк не курсивом
(custom-set-faces!
  '(line-number :slant normal :weight normal :family "Hack Nerd Font")
  '(line-number-current-line :slant normal :weight bold :family "Hack Nerd Font"))

;; Blink cursor
(blink-cursor-mode 1)

;; Установка темы
;;(setq doom-theme 'oxocarbon)
;;(setq doom-theme 'doom-solarized-dark-high-contrast)
(setq doom-theme 'ef-dark)
;;(setq doom-theme 'doom-henna)
;;(custom-set-faces!
  ;;'(fringe :background "#000000")
  ;;'(line-number-current-line
    ;;:background "#262626"
    ;;:foreground "#e65535"
    ;;:weight bold))
   ;;Убрать только нижний разделитель
;;(setq window-divider-default-places 'right-only) ;; Разделители только справа
(setq window-divider-default-bottom-width 0)    ;; Отключить нижний разделитель

 ;;Активировать изменения
;;(window-divider-mode 1)
 ;;Жирный шрифт для выделения

;; Относительная нумерация строк
(setq display-line-numbers-type 'relative)

(set-language-environment "UTF-8")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defconst my-evil-key-translation                                   ;;
;;   '(("й" . "q")  ("ц" . "w")  ("у" . "e")  ("к" . "r")              ;;
;;     ("е" . "t")  ("н" . "y")  ("г" . "u")  ("ш" . "i")              ;;
;;     ("щ" . "o")  ("з" . "p")  ("х" . "[")  ("ъ" . "]")              ;;
;;     ("ф" . "a")  ("ы" . "s")  ("в" . "d")  ("а" . "f")              ;;
;;     ("п" . "g")  ("р" . "h")  ("о" . "j")  ("л" . "k")              ;;
;;     ("д" . "l")  ("ж" . ";")  ("э" . "'")                           ;;
;;     ("я" . "z")  ("ч" . "x")  ("с" . "c")  ("м" . "v")              ;;
;;     ("и" . "b")  ("т" . "n")  ("ь" . "m")  ("б" . ",")              ;;
;;     ("ю" . ".")  ("ё" . "`")  ("Ж" . ":")))                         ;;
;;                                                                     ;;
;; (defun my-translate-evil-keys (keymap)                              ;;
;;   "Переназначает русские клавиши на английские в указанном keymap." ;;
;;   (dolist (pair my-evil-key-translation)                            ;;
;;     (define-key keymap (kbd (car pair)) (kbd (cdr pair)))))         ;;
;;                                                                     ;;
;; (use-package evil                                                   ;;
;;   :config                                                           ;;
;;   (my-translate-evil-keys evil-normal-state-map)                    ;;
;;   (my-translate-evil-keys evil-visual-state-map)                    ;;
;;   (my-translate-evil-keys evil-motion-state-map))                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(after! python
 ;; (setq python-shell-interpreter "python3"
  ;;      python-shell-interpreter-args "-i"))

;; Autoformat with Black on save
(use-package! blacken
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-line-length 100))

;; Configure LSP behavior
(setq lsp-pyright-auto-import-completions t
      lsp-pyright-use-library-code-for-types t)

(after! lsp-mode
  (setq lsp-diagnostics-provider :flycheck))

(use-package! lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-sideline-enable t                ; Включить боковые подсказки
        lsp-ui-sideline-show-diagnostics t      ; Показывать диагностику
        lsp-ui-sideline-show-hover nil          ; Отключить всплывающие подсказки
        lsp-ui-doc-enable nil                   ; Отключить всплывающие окна
        lsp-ui-sideline-ignore-duplicate t      ; Не дублировать подсказки
        lsp-ui-sideline-update-mode 'point))    ; Обновлять подсказки при наведении курсора

;; (use-package! conda
;;   :init
;;   (setq conda-env-home-directory (expand-file-name "/opt/anaconda3"))
;;   (setq conda-anaconda-home (expand-file-name "/opt/anaconda3"))
;;   :config
;;   (conda-env-initialize-interactive-shells)
;;   (conda-env-initialize-eshell)
 ;; (conda-env-autoactivate-mode t))

(after! flycheck
   (setq flycheck-indication-mode 'left-fringe)  ;; Иконки отображаются слева
   (custom-set-faces
    '(flycheck-error ((t (:foreground "red" :weight bold :underline t))))
    '(flycheck-warning ((t (:foreground "yellow" :weight bold :underline t))))
    '(flycheck-info ((t (:foreground "blue" :weight bold :underline t))))))

;; Устанавливаем директорию для Org-файлов
(setq org-directory "~/orgfiles/")

;; Настраиваем файлы для org-agenda
(after! org
  (setq org-agenda-files
        '("~/orgfiles/")))
(setq org-agenda-skip-unavailable-files t)

;; Автоперенос длинных строк в Org-mode
(add-hook 'org-mode-hook #'visual-line-mode)

(defun my/org-hide-body-and-narrow-visibility ()
  "Настраивает стартовое отображение Org файла, чтобы показывались только заголовки 1 и 2 уровня, скрывая все содержимое."
  (outline-hide-sublevels 2))

;; Хук для применения настроек только при открытии Org файла
(add-hook 'org-mode-hook #'my/org-hide-body-and-narrow-visibility)

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

;; Включить nyan-mode
(use-package! nyan-mode
  :config
  (setq nyan-wavy-trail t          ;; Включить "волнистый след"
        nyan-animate-nyancat t     ;; Анимация Nyancat
        nyan-bar-length 20))        ;; Длина

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))
