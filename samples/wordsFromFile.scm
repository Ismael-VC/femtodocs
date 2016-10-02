
(define (punctuation-mark? c)
  (not (not (string.find ".;:,?!()" c)) ))

(define (ignore-blank c s)
   (cond ( (eof-object? c) '())
         ( (or (eqv? c #\space) (eqv? c #\newline)) 
           (ignore-blank (io.getc s) s))
         ( (punctuation-mark? c)
           (cons (string c) 
                 (ignore-blank (io.getc s) s)))
         (else (word c s '()) ) )) 

(define (word c s xs)
   (cond ( (eof-object? c)
           (list (apply string (reverse xs))))
         ( (eqv? c #\space)
           (cons (apply string (reverse xs))
                 (ignore-blank (io.getc s) s)))
         ( (eof-object? (io.peekc s))
           (apply string (reverse (cons c xs)) ))
         ( (punctuation-mark? (io.peekc s))
           (cons (apply string (reverse (cons c xs)))
                 (ignore-blank (io.getc s) s)))
         ( (io.eof? s)
           (list (apply string (reverse xs))))
         (else (word (io.getc s) s (cons c xs)) ) ))

(define (rdList fname)
   (let ( (in (file fname :read)))
         (ignore-blank (io.getc in) in)))

