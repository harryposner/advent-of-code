(import (chicken io))
(import (chicken irregex))
(import srfi-1)    ;;; List operations
(import srfi-113)  ;;; Sets and bags
(import srfi-128)  ;;; Comparators (necessary for sets)


(define input (call-with-input-file "day_3_input.txt" read-lines))


(define-record claim id west north width height)


(define (string->claim line)
  (apply make-claim (map string->number
                         (irregex-extract "\\d+" line))))

(define claims (map string->claim input))

(define (cartesian-product a-list . more-lists)
  (if (null? more-lists)
      (map list a-list)
      (apply append
             (map (lambda (tuple) (map (lambda (element) (cons element tuple))
                                       a-list))
                  (apply cartesian-product more-lists)))))

(define (claim-covers claim)
  (cartesian-product (iota (claim-width claim) (claim-west claim))
                     (iota (claim-height claim) (claim-north claim))))


(define *fabric* (bag (make-default-comparator)))

(for-each
  (lambda (claim)
    (apply bag-adjoin! (cons *fabric* (claim-covers claim))))
  claims)


(display "Part 1: ")
(print
  (bag-fold-unique
    (lambda (coord count accum) (if (>= count 2) (add1 accum) accum))
    0
    *fabric*))


(display "Part 2: ")
(print
  (let loop-claims ((remaining-claims claims))
    (let loop-coords ((remaining-coords (claim-covers (car remaining-claims))))
      (cond
        ((null? remaining-claims) (error "Part 2: checked all claims"))
        ((null? remaining-coords) (claim-id (car remaining-claims)))
        ((< 1 (bag-element-count *fabric* (car remaining-coords)))
         (loop-claims (cdr remaining-claims)))
        (else (loop-coords (cdr remaining-coords)))))))
