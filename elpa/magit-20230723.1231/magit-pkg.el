(define-package "magit" "20230723.1231" "A Git porcelain inside Emacs."
  '((emacs "25.1")
    (compat "29.1.3.4")
    (dash "20221013")
    (git-commit "20230101")
    (magit-section "20230101")
    (transient "20230201")
    (with-editor "20230118"))
  :commit "2c2b34d7ac8a595be68702e53ff6f77755bfcd52" :authors
  '(("Marius Vollmer" . "marius.vollmer@gmail.com")
    ("Jonas Bernoulli" . "jonas@bernoul.li"))
  :maintainer
  '("Jonas Bernoulli" . "jonas@bernoul.li")
  :keywords
  '("git" "tools" "vc")
  :url "https://github.com/magit/magit")
;; Local Variables:
;; no-byte-compile: t
;; End:
