(add-hook 'c-mode-hook
          (lambda ()
            (define-key c-mode-map (kbd "C-c , c") 'rr/nand2tetris-simulate-and-compare)
            (define-key c-mode-map (kbd "SPC") 'self-insert-command)))

(add-to-list 'auto-mode-alist '(".hdl$" . c-mode))

(defun rr/nand2tetris-simulate-and-compare ()
  (interactive)
  (rr/nand2tetris-rm-out)
  (message (rr/nand2tetris-simulate-hdl))
  (rr/nand2tetris-compare-out))

(defun rr/nand2tetris-rm-out ()
  (interactive)
  (->> (buffer-file-name)
       (replace-regexp-in-string ".hdl$" ".out")
       (format "rm %s")
       (shell-command)))

(defun rr/nand2tetris-simulate-hdl ()
  (interactive)
  (shell-command-to-string
   (rr/nand2tetrist-simulate-hdl-command)))

(defun rr/nand2tetrist-simulate-hdl-command ()
  (->> (buffer-file-name)
       (replace-regexp-in-string ".hdl$" ".tst")
       (format
        "%snand2tetris/tools/HardwareSimulator.sh %s"
        (projectile-project-root))))

(defun rr/nand2tetris-compare-out ()
  (interactive)
  (let ((out-file (replace-regexp-in-string ".hdl$"
                                            ".out"
                                            (buffer-file-name)))
        (cmp-file (replace-regexp-in-string ".hdl$"
                                            ".cmp"
                                            (buffer-file-name))))
    (diff out-file cmp-file)))
