(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
(package-initialize)

;; use-package 설치
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; 맥일 경우 환경변수를 못 가져 오는 경우가 있어서 셋팅
(use-package exec-path-from-shell
  :ensure t
  :config (when (eq system-type 'darwin));;맥일경우
	    (exec-path-from-shell-initialize))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
  	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 ("C-x f" . helm-recentf))
  :bind (:map helm-map
  	      ("<tab>" . helm-execute-persistent-action)
	      ("C-i" . helm-execute-persistent-action))
  :config (helm-mode 1))

(use-package magit
  :ensure t)

(use-package helm-ag ; Helm interface for Ag
  :ensure t
  :bind ("C-c M-s" . helm-do-ag)
  :config (setq helm-ag-fuzzy-match t
                helm-ag-insert-at-point 'symbol
                helm-ag-source-type 'file-line))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package helm-projectile ; Projectile through Helm
  :ensure t
  :init (with-eval-after-load 'projectile (helm-projectile-on))
  :config (setq projectile-switch-project-action #'helm-projectile))

(use-package helm-descbinds
  :ensure t
  :config (helm-descbinds-mode))

;SF Mono 사용
(set-face-attribute 'default nil :font "SF Mono-16:light")
(set-frame-font "SF Mono-16:light" t)
;한글일 경우 나눔고딕코딩 사용
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
;(set-face-attribute 'default nil :height 200)
;(set-face-attribute 'default nil :weight "Light")

(use-package dracula-theme
  :ensure t
  :config (load-theme 'dracula t))

(use-package js2-mode
  :ensure t
  :mode (("\\.js$" . js2-mode))
  :config (progn
            (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
            (add-hook 'js2-mode-hook (lambda () (setq js-switch-indent-offset 2)))))

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(use-package web-mode
  :ensure t
  :mode ("\\.html$" . web-mode)
  :config (progn
            (add-hook 'web-mode-hook (lambda () (setq web-mode-markup-indent-offset 2)))
            (add-hook 'web-mode-hook (lambda () (setq web-mode-enable-current-element-highlight t)))))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;; Disable file~
(setq backup-inhibited t)
;; Disable #file#
(setq auto-save-visited-file-name t)
;; Disable Interlocking
(setq create-lockfiles nil)
;; Set Auto save timeout
(setq auto-save-timeout 2)

(setq global-linum-mode t)
(use-package hlinum
  :ensure t
  :config (hlinum-activate))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (hlinum real-auto-save web-mode js2-mode dracula-theme expand-region helm-descbinds exec-path-from-shell ag helm-ag helm-projectile use-package magit helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
