(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(use-package ddskk
  :ensure t
  :config
  (global-set-key (kbd "C-x C-j") 'skk-mode)
  (setq skk-jisyo-code 'utf-8))

(use-package eglot
  :ensure t
  :config
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-,") 'pop-tag-mark)
  (add-to-list 'eglot-server-programs
	           '(julia-mode . ("julia" "-e using LanguageServer, LanguageServer.SymbolServer; runserver()")))
  (add-hook 'julia-mode-hook 'julia-repl-mode)
  )

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-dabbrev-downcase nil)
  (setq company-selection-wrap-around t))

(use-package haskell-mode
  :ensure t)

(use-package julia-mode
  :ensure t)
(use-package julia-repl
  :ensure t)
