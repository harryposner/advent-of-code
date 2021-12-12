;;; line  ::= chunk+
;;; chunk ::= "(" chunk* ")"
;;;         | "[" chunk* "]"
;;;         | "{" chunk* "}"
;;;         | "<" chunk* ">"

(import (chicken io)
        (chicken sort))

(define (parse line)
  (call/cc (lambda (error-continuation)
             (parse-line error-continuation line))))

(define (parse-line err tokens)
  (let ((new-tokens (parse-chunk err tokens '())))
    (if (null? new-tokens)
      #f
      (parse-line err new-tokens))))

(define (parse-chunk err tokens autocomplete-stack)
  (let* ((expect (case (car tokens)
                   (( #\(  ) #\))
                   (( #\[  ) #\])
                   (( #\{  ) #\})
                   (( #\<  ) #\>)
                   (else (err #:bad-char (bad-char-score (car tokens)))))))
    (cond
      ((null? (cdr tokens))
       (err #:incomplete
            (autocomplete-score (cons expect autocomplete-stack))))
      ((char=? expect (cadr tokens))
       (cddr tokens))
      (else
        (let loop ((new-tokens (parse-chunk err
                                            (cdr tokens)
                                            (cons expect
                                                  autocomplete-stack))))
          (cond
            ((null? new-tokens)
             (err #:incomplete
                  (autocomplete-score (cons expect autocomplete-stack))))
            ((member (car new-tokens) '(#\( #\[ #\{ #\<))
             (loop (parse-chunk err
                                new-tokens
                                (cons expect autocomplete-stack))))
            ((not (char=? expect (car new-tokens)))
             (err #:bad-char (bad-char-score (car new-tokens))))
            (else (cdr new-tokens))))))))

(define (bad-char-score char)
  (case char
    (( #\) ) 3)
    (( #\] ) 57)
    (( #\} ) 1197)
    (( #\> ) 25137)))

(define (autocomplete-score stack)
  (foldl (lambda (acc char)
           (+ (* 5 acc)
              (case char
                (( #\) ) 1)
                (( #\] ) 2)
                (( #\} ) 3)
                (( #\> ) 4))))
         0
         stack))

(define (main)
  (let loop ((part-1-acc 0)
             (part-2-acc '()))
    (let ((raw-line (read-line)))
      (if (eof-object? raw-line)
        (begin
          (display part-1-acc)
          (newline)
          (display (list-ref (sort part-2-acc <)
                             (quotient (length part-2-acc)
                                       2)))
          (newline))
        (let-values (((err-type err-val) (parse (string->list raw-line))))
          (case err-type
            ((#:bad-char) (loop (+ part-1-acc err-val)
                                part-2-acc))
            ((#:incomplete) (loop part-1-acc
                                  (cons err-val part-2-acc)))))))))

(main)
