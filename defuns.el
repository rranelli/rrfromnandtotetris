(add-hook 'c-mode-hook
          (lambda ()
            (define-key c-mode-map (kbd "C-c , c") 'rr/nand2tetris-simulate-and-compare)
            (define-key c-mode-map (kbd "C-c c i") 'rr/insert-chip)
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


(defvar rr/chip-api '("Add16(a=, b=, out= );"
                      "ALU(x=, y=, zx=, nx=, zy=, ny=, f=, no=, out=, zr=, ng= );"
                      "And16(a=, b=, out= );"
                      "And(a=, b=, out= );"
                      "ARegister(in=, load=, out= );"
                      "Bit(in=, load=, out= );"
                      "CPU(inM=, instruction=, reset=, outM=, writeM=, addressM=, pc= );"
                      "DFF(in=, out= );"
                      "DMux4Way(in=, sel=, a=, b=, c=, d= );"
                      "DMux8Way(in=, sel=, a=, b=, c=, d=, e=, f=, g=, h= );"
                      "DMux(in=, sel=, a=, b= );"
                      "DRegister(in=, load=, out= );"
                      "FullAdder(a=, b=, c=, sum=, carry= );"
                      "HalfAdder(a=, b=, sum=,  carry= );"
                      "Inc16(in=, out= );"
                      "Keyboard(out= );"
                      "Memory(in=, load=, address=, out= );"
                      "Mux16(a=, b=, sel=, out= );"
                      "Mux4Way16(a=, b=, c=, d=, sel=, out= );"
                      "Mux8Way16(a=, b=, c=, d=, e=, f=, g=, h=, sel=, out= );"
                      "Mux(a=, b=, sel=, out= );"
                      "Nand(a=, b=, out= );"
                      "Not16(in=, out= );"
                      "Not(in=, out= );"
                      "Or16(a=, b=, out= );"
                      "Or8Way(in=, out= );"
                      "Or(a=, b=, out= );"
                      "PC(in=, load=, inc=, reset=, out= );"
                      "RAM16K(in=, load=, address=, out= );"
                      "RAM4K(in=, load=, address=, out= );"
                      "RAM512(in=, load=, address=, out= );"
                      "RAM64(in=, load=, address=, out= );"
                      "RAM8(in=, load=, address=, out= );"
                      "Register(in=, load=, out= );"
                      "ROM32K(address=, out= );"
                      "Screen(in=, load=, address=, out= );"
                      "Xor(a=, b=, out= );"))

(defun rr/insert-chip ()
  (interactive)
  (helm :sources '((name . "insert chip")
                   (candidates . rr/chip-api)
                   (action-transformer . (lambda (_ var) (insert var))))
        :buffer "*helm-chip-completion*"))
