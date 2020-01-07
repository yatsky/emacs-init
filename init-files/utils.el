(defun is-gnu-linux ()
  "Return true is the current os is gnu/linux"
  (string-equal system-type "gnu/linux")
  )

(defun get-wd ()
  "Get my working directory"
  (if
      (is-gnu-linux)
      "/mnt/c/Users/thoma/Dev"
    "C:\\Users\\thoma\\Dev")
  )
