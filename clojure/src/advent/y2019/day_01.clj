(ns advent.y2019.day-01
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

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

(defn module-masses
  [input]
  (->> input
       string/split-lines
       (map #(Integer/parseInt %))))

(defn part-1
  [input]
  (let [masses (module-masses input)]
    (apply + (map mass->fuel masses))))

(defn part-2
  [input]
  (let [masses (module-masses input)]
    (apply + (map rocket-equation masses))))

(defn -main
  []
  (let [masses (module-masses (aoc/input 2019 1))]
    (println "Part 1:" (apply + (map mass->fuel masses)))
    (println "Part 2:" (apply + (map rocket-equation masses)))))

(comment
 (-main))
