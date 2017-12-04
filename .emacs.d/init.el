;; 에러시 디버그모드
;; (setq debug-on-error t)

(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(define-key global-map (kbd "C-j") nil)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)
(setq mac-command-key-is-meta t)

(set-face-attribute 'default nil :font "SF Mono-16:light")
(set-frame-font "SF Mono-16:light" t)
;한글일 경우 나눔고딕코딩 사용
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(global-whitespace-mode 1)

;; Disable file~
(setq backup-inhibited t)
;; Disable #file#
(setq auto-save-visited-file-name t)
;; Disable Interlocking
(setq create-lockfiles nil)
;; Set Auto save timeout
(setq auto-save-timeout 2)

(global-linum-mode t)
(global-hl-line-mode t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
   (when (file-exists-p custom-file)
       (load custom-file))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;; hippie-expand
(global-set-key "\M-n" 'hippie-expand)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; use-package 설치
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config (exec-path-from-shell-initialize))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 20)
                          (bookmarks . 10)
                          (projects . 10))))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (setq which-key-idle-delay 2)
  (setq which-key-max-description-length 40)
  (setq which-key-max-display-columns nil)
  (which-key-setup-side-window-bottom)
  (which-key-mode))

(use-package rainbow-mode
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package magit
  :commands magit-get-top-dir
  :diminish auto-revert-mode
  :ensure t
  :init
  ;; magit 오토 리버트시 버퍼의 브랜치명까지 갱신하도록
  (setq auto-revert-check-vc-info t)

  ;;; 이맥스가 기본적으로 제공하는 Git 백엔드를 켜두면 매우 느려진다. magit만 쓴다.
  (setq vc-handled-backends nil)
  :config
  (setq magit-refresh-status-buffer 'switch-to-buffer)
  (setq magit-rewrite-inclusive 'ask)
  (setq magit-save-some-buffers t)
  (setq magit-set-upstream-on-push 'askifnotset)
  :bind
  ("C-c m" . magit-status))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package dracula-theme
  :ensure t
  :config (load-theme 'dracula t))

(use-package js2-mode
  :ensure t
  :mode (("\\.js$" . js2-mode))
  :config (progn
            (add-hook 'js2-mode-hook
                      (lambda () (setq js2-basic-offset 2)))
            (add-hook 'js2-mode-hook
                      (lambda () (setq js-switch-indent-offset 2)))))

(defvaralias 'web-mode-enable-current-element-highlight 'cur-hili)
(use-package web-mode
  :ensure t
  :mode ("\\.html$" . web-mode)
  :config (progn
            (add-hook 'web-mode-hook
                      (lambda () (setq web-mode-markup-indent-offset 2)))
            (add-hook 'web-mode-hook
                      (lambda ()
                        (setq cur-hili t)))))

(use-package company
  :ensure t
  :diminish company-mode
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-idle-delay 0.1)
;  (setq company-show-numbers t)
  (setq company-tooltip-limit 10)
  (setq company-dabbrev-downcase nil)
  (setq company-minimum-prefix-length 2)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(use-package neotree
  :ensure t)

(use-package ace-window
  :ensure t
  :config
  (setq aw-keys '(?1 ?2 ?3 ?4 ?5))
  :bind ("C-x o" . ace-window))

(use-package avy
  :ensure t
  :bind
  ("C-j j". avy-goto-word-1)
  ("C-j C-j". avy-goto-word-1)
  ("C-j k". avy-goto-char-2)
  ("C-j g". avy-goto-line)
  ("C-j C-g". avy-goto-line))

(use-package ibuffer
  :ensure t
  :init
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (autoload 'ibuffer "ibuffer" "List buffers." t))

(use-package delight
  :ensure t)

(use-package smex
  :ensure t)

;;;; swiper and ivy
(use-package swiper
  :ensure t
  :diminish ivy-mode
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  ;; number of result lines to display
  (setq ivy-height 12)
  ;; does not count candidates
  (setq ivy-count-format "")
  (setq ivy-switch-buffer-faces-alist
        '((emacs-lisp-mode . outline-1)
          (dired-mode . outline-2)
          (js2-mode . outline-4)
          (clojure-mode . outline-5)
          (org-mode . outline-3)))
  :bind
  (("M-x". counsel-M-x)
   ("C-x C-f". counsel-find-file)
   ("C-c r". counsel-recentf)
   ("C-c g". counsel-projectile-rg)
   ("C-c e". ivy-switch-buffer)
   ("C-c 4 e". ivy-switch-buffer-other-window)
   ("C-c o". counsel-imenu)
   ("C-c y" . counsel-yank-pop)
   ("C-x r l" . counsel-bookmark)
   ("C-j i". swiper)
   ("C-j o". swiper-all)
   :map ivy-mode-map
   ("S-SPC" . toggle-input-method)
   :map ivy-minibuffer-map
   ("C-j" . ivy-alt-done)))

(use-package projectile
  :ensure t
  :init
  (projectile-global-mode)
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  ;;; 아무데서나 프로젝타일을 사용하게하려면 주석해제
  ;; (setq projectile-require-project-root nil)
  (setq projectile-indexing-method 'alien)
  (setq projectile-globally-ignored-directories
        (append '(".DS_Store" ".git" ".svn" "out" "repl" "target" "dist" "lib"
                  "node_modules" "libs" "deploy")
                projectile-globally-ignored-directories))
  (setq projectile-globally-ignored-files
        (append '(".#*" ".DS_Store" "*.tar.gz" "*.tgz" "*.zip" "*.png" "*.jpg"
                  "*.gif")
                projectile-globally-ignored-files))
  (setq grep-find-ignored-directories (append '("dist" "deploy" "node_modules")
                                              grep-find-ignored-directories))
  :bind
  ;; 오타방지용 바인드들
  ("C-c C-p f" . projectile-find-file)
  ("C-c C-p 4 f" . projectile-find-file-other-window)
  ("C-c C-p b" . projectile-switch-to-buffer)
  ("C-c C-p 4 b" . projectile-switch-to-buffer-other-window)
  ("C-c C-p D" . projectile-dired)
  ("C-c C-p d" . projectile-find-dir)
  ("C-c C-p j" . projectile-find-tag)
  ("C-c C-p r" . projectile-replace)
  ("C-c C-p o" . projectile-multi-occur)
  ("C-c C-p s s" . counsel-projectile-ag)
  ("C-c C-g" . counsel-projectile-rg)
  ("C-c C-p I" . projectile-ibuffer)
  ("C-c C-p p" . projectile-switch-project))

(use-package ibuffer-projectile
  :ensure t
  :init
  (add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))

(use-package counsel
  :ensure t)

(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-on))

(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/zsh")
  :bind
  ("C-c i" . multi-term))

;; terminal(멀티텀포함)에서 C-j를 글로벌 맵이용하도록 훅
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-j")
              (lookup-key (current-global-map) (kbd "C-j")))))

(use-package google-translate
  :ensure t
  :init
  (require 'google-translate)
  (require 'google-translate-smooth-ui)
  (setq google-translate-translation-directions-alist
        '(("en" . "ko") ("ko" . "en")))
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-output-destination 'echo-area)
  (setq max-mini-window-height 0.5)
  :bind
  ("C-c n" . google-translate-smooth-translate))

(use-package beacon
  :ensure t
  :diminish beacon-mode
  :config
  (beacon-mode 1))

(use-package tern
  :ensure t
  :diminish tern-mode
  :init
  (autoload 'tern-mode' "tern.el" nil t)
  (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :config
  (define-key tern-mode-keymap (kbd "C-c C-r") nil)
  ;; (define-key tern-mode-keymap (kbd "M-.") nil)
  ;; (define-key tern-mode-keymap (kbd "M-,") nil)
  (setq tern-command '("tern" "--no-port-file")))

(use-package company-tern
  :ensure t
  :init
  (setq company-tern-property-marker nil)
  (setq company-tern-meta-as-single-line t)
  (setq company-tooltip-align-annotations t)
  (add-to-list 'company-backends 'company-tern))
