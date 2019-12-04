(import (chicken io))
(import srfi-113)  ;;; Sets and bags
(import srfi-128)  ;;; Comparators (necessary for sets)

(define input (call-with-input-file "day_1_input.txt" read-list))

(display "Part 1: ")
(print (apply + input))

(display "Part 2: ")


(define real-comparator (make-comparator real? = < number-hash))

;;; Yes, I have to mutate the set.  The functional approach is ridiculously
;;; slow.
(let ((seen (set real-comparator)))
  (let loop ((frequency 0)
             (remaining-deltas input))
    (if (set-contains? seen frequency)
        (print frequency)
        (begin
          (set-adjoin! seen frequency)
          (loop (+ frequency (car remaining-deltas))
                (if (null? (cdr remaining-deltas) )
                    input
                    (cdr remaining-deltas)))))))
