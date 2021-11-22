(import (chicken io))


(define (mass->fuel mass)
  (- (floor (/ mass 3))
     2))

(define (rocket-equation mass)
  (if (<= mass 0)
      0
      (let ((fuel (mass->fuel mass)))
        (+ fuel
           (rocket-equation fuel)))))

(define module-masses
  (map string->number
       (call-with-input-file "input.txt" read-lines)))

(print "Part 1: " (apply + (map mass->fuel module-masses)))
(print "Part 2: " (apply + (map rocket-equation module-masses)))
