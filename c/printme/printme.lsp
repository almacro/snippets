(printme (lambda nil (prog (a b)
  (setq a (quote (printme (lambda nil (prog (a b)
    (setq a (quote foo))
    (setq b (copy a))
    (rplaca (cdaddr (caddar (cddadr b))) a)
    (return b))))))
  (setq b (copy a))
  (rplaca (cdaddr (caddar (cddadr b))) a)
  (return b))))
