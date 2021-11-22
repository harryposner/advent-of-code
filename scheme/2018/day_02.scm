(import (chicken io))
(import srfi-1)    ;;; List procedures
(import srfi-113)  ;;; Sets and bags
(import srfi-128)  ;;; Comparators (necessary for sets)

(define input (call-with-input-file "day_2_input.txt" read-lines))

(define char-comparator (make-comparator char? char=? char<? char-hash))


(define (exactly-n? n box-id)
  (let* ((char-list (string->list box-id))
         (char-bag (list->bag char-comparator char-list)))
    (foldl (lambda (x y) (or x (= y n)))
           #f
           (map (lambda (char) (bag-element-count char-bag char))
                char-list))))

(define (count-exactly-n n box-ids)
  (apply + (map (lambda (box-id) (if (exactly-n? n box-id) 1 0))
                box-ids)))

(display "Part 1: ")
(let ((n2 (count-exactly-n 2 input))
      (n3 (count-exactly-n 3 input)))
  (print (* n2 n3)))


(define (common-letters id1 id2)
  (let ((id1-list (string->list id1))
        (id2-list (string->list id2)))
    (map car
         (filter (lambda (x) (char=? (car x) (cadr x)))
                 (map list id1-list id2-list)))))


(define (diff-by-one? id1 id2)
  (let ((id1-list (string->list id1))
        (id2-list (string->list id2)))
    (= 1
       (- (length id1-list)
          (length (common-letters id1 id2))))))


(define (find-boxes all-boxes)
  (let outer-loop ((remaining-outer all-boxes))
    (if (null? remaining-outer)
        (error "Checked all boxes, no two diff-by-one")
        (let inner-loop ((checking (car remaining-outer))
                        (remaining-inner (cdr remaining-outer)))
          (if (null? remaining-inner)
              (outer-loop (cdr remaining-outer))
              (let ((against (car remaining-inner)))
                (if (diff-by-one? checking against)
                    (list checking against)
                    (inner-loop checking (cdr remaining-inner)))))))))


(display "Part 2: ")
(let ((result (find-boxes input)))
  (print (list->string (apply common-letters result))))
