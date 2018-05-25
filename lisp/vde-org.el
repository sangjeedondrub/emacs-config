(use-package org
  :defer t
  :mode (("\\.org$" . org-mode))
  :commands (org-capture org-agenda)
  :ensure org-plus-contrib
  :hook (org-mode . vde/org-mode-hook)
  :config
  (require 'org-protocol)
  (setq org-modules
        '(org-habit org-info org-docview))
  (setq org-todo-keywords
        '((sequence "TODO" "WAITING(!)" "SOMEDAY(!)" "|" "DONE(!)" "CANCELED(!)")
          (sequence "IDEA")))
  (setq org-blank-before-new-entry '((heading . t)
                                     (plain-list-item . t)))
  (setq org-directory "~/sync/org/")
  
  (setq org-log-done (quote time))
  (setq org-log-redeadline (quote time))
  (setq org-log-reschedule (quote time))
  (setq org-log-into-drawer t)

  (setq org-pretty-entities t)
  (setq org-insert-heading-respect-content t)
  (setq org-ellipsis " …")
  
  (setq org-tag-alist '(("@cal" . ?c)
                        ("@home" . ?h)))
  (setq org-agenda-skip-scheduled-if-done t))

(use-package org-projectile
  :defer 3
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    (setq org-projectile-projects-file
          "~/sync/org/projects.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    (push (org-projectile-project-todo-entry) org-capture-templates)))

(defun vde/org-mode-hook ()
  "Org-mode hook"
  (setq show-trailing-whitespace t)
  (when (not (eq major-mode 'org-agenda-mode))
    (setq fill-column 120)
    (flyspell-mode)
    (org-indent-mode)))

(use-package smartparens-org)

(use-package ox-hugo
  :after ox
  :commands (org-hugo-slug)
  :bind (:map vde-mode-map
              ("C-c G" . org-hugo-export-wim-to-md)))

(provide 'vde-org)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
