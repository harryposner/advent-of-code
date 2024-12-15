(ns advent.y2021.day-01
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn part-1
  [data]
  (->> data
       (partition 2 1)
       (filter (fn [[x y]] (> y x)))
       count))

(defn part-2
  [data]
  (->> data
       (partition 3 1)
       (map (partial apply +))
       part-1))

(defn -main
  []
  (let [data (map #(Integer/parseInt %) (string/split-lines (aoc/input 2021 1)))]
    (println "Part 1: " (part-1 data))
    (println "Part 2: " (part-2 data))))
