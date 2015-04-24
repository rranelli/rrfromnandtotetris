(add-hook 'vhdl-mode-hook
          (lambda ()
            (define-key vhdl-mode-map (kbd "C-c , c") 'rr/nand2tetris-simulate-and-compare)
            (define-key vhdl-mode-map (kbd "SPC") 'self-insert-command)))

(add-to-list 'auto-mode-alist '(".hdl$" . vhdl-mode))

(defun rr/nand2tetris-simulate-and-compare ()
  (interactive)
  (rr/nand2tetris-rm-out)
  (rr/nand2tetris-simulate-hdl)
  (rr/nand2tetris-compare-out))

(defun rr/nand2tetris-rm-out ()
  (interactive)
  (->> (buffer-file-name)
       (replace-regexp-in-string ".hdl$" ".out")
       (format "rm %s")
       (shell-command)))

(defun rr/nand2tetris-simulate-hdl ()
  (interactive)
  (->> (buffer-file-name)
       (replace-regexp-in-string ".hdl$" ".tst")
       (format
        "%snand2tetris/tools/HardwareSimulator.sh %s"
        (projectile-project-root))
       (shell-command)))

(defun rr/nand2tetris-compare-out ()
  (interactive)
  (let ((out-file (replace-regexp-in-string ".hdl$"
                                            ".out"
                                            (buffer-file-name)))
        (cmp-file (replace-regexp-in-string ".hdl$"
                                            ".cmp"
                                            (buffer-file-name))))
    (diff out-file cmp-file)))
