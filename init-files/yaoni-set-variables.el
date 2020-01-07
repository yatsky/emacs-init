 (setq initial-buffer-choice
   ;; We have to use find-file to open the buffer
   ;; because initial-buffer-choice selects the buffer the function returns.
   ;; instead of visiting/finding the file/directory when given a string.
       (lambda nil
     (find-file
      (get-wd))))
