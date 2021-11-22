(require '[clojure.string :as string])


(defn mass->fuel [mass]
  (- (quot mass 3)
     2))

(defn rocket-equation [mass]
  (loop [total-fuel 0
         incr-fuel (mass->fuel mass)]
    (if (zero? incr-fuel)
        total-fuel
        (recur (+ total-fuel incr-fuel)
               (max 0 (mass->fuel incr-fuel))))))

(def module-masses
  (->> "input.txt"
       slurp
       string/split-lines
       (map #(Integer/parseInt %))))

(println "Part 1:" (apply + (map mass->fuel module-masses)))
(println "Part 2:" (apply + (map rocket-equation module-masses)))
