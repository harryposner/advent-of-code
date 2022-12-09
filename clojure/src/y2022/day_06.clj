(ns y2022.day-06
  (:require [aocd.core :as aoc]))

(defn solve
  [input window-size]
  (->> input
       (partition window-size 1)
       (map-indexed vector)
       (drop-while (fn [[_ window]] (not= window-size (count (distinct window)))))
       ffirst
       (+ window-size)))

(defn -main
  []
  (let [input (aoc/input 2022 6)]
    (println (solve input 4))
    (println (solve input 14))))
