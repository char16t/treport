;; If you have any questions feel free contact to
;; Valeriy Manenkov (v.manenkov@gmail.com)

(require 'org)
(require 'cl)

(setq treport/org-main-file (concat "~/OrgMode/reports/daily-log-" (format-time-string "%Y-%m-%d") ".org"))

(defun treport/move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun treport/move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun treport/log-done-thing (thing)
  (interactive "sDone: ")
  (unless (file-readable-p treport/org-main-file)
    (treport/create-today-daily-log))
  (with-current-buffer (find-file-noselect treport/org-main-file)
    (save-excursion
      (let ((pos (org-find-exact-headline-in-buffer "Done")))
        (assert pos nil "Task %s not found in file %s." task treport/org-main-file)
        (goto-char pos)
        (org-insert-heading)
        (insert thing)
        (org-do-demote)
	(treport/move-line-down)))))


(defun treport/log-time-to-category ()
  (interactive)
  (treport/log-time-to-category-private treport/time-spent-categories))

(defun treport/log-time-to-category-private (lst)
  (interactive)
  (let ((choice (read-char-choice
         (mapconcat
          (lambda (item) (format "%c: %s" (car item) (cadr item))) lst "; ")
         (mapcar #'car lst))))
    (let ((child (nth 3 (nth (- (string-to-number (format "%s" (format "%c" choice))) 1) lst))))
      (if (not (eq child nil))
	 (treport/log-time-to-category-private child)
	(funcall (lambda (task) (treport/org-clock-in task)) (nth 2 (nth (- (string-to-number (format "%s" (format "%c" choice))) 1) lst)))))))

(defun treport/create-today-daily-log ()
  (interactive)
  (unless (file-exists-p treport/org-main-file)
    (let ((content (with-temp-buffer
		    (insert-file-contents "~/OrgMode/DailyLogEthalon.org")
		    (buffer-string))))
      (write-region content nil treport/org-main-file))))

(defun treport/org-clock-in (task)
  "Clock in for TASK in `treport/org-main-file'."
  (interactive "sTask: ")
  (unless (file-readable-p treport/org-main-file)
    (treport/create-today-daily-log))
  (with-current-buffer (find-file-noselect treport/org-main-file)
    (save-excursion
      (let ((pos (org-find-exact-headline-in-buffer task)))
        (assert pos nil "Task %s not found in file %s." task treport/org-main-file)
        (goto-char pos)
        (org-clock-in)
        (save-buffer)
        ))))

(defun treport/exit ()
	    (with-current-buffer (find-file-noselect treport/org-main-file)
	      (save-excursion
		(org-clock-out nil t)
		(save-buffer))))

(provide 'treport)

