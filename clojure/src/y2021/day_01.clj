(ns y2021.day-01
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn part-1
  [data]
  (:total (reduce (fn [{:keys [total prev]} current]
                    {:total (if (< prev current)
                              (inc total)
                              total)
                     :prev current})
                  {:total 0 :prev (first data)}
                  (rest data))))

(defn part-2
  [data]
  (->> data
       (partition 3 1)
       (map (partial apply +))
       part-1))

(defn -main
  []
  (let [data (->> (aoc/input 2021 1)
                  (string/split-lines)
                  (map #(Integer/parseInt %)))]
    (println "Part 1: " (part-1 data))
    (println "Part 2: " (part-2 data))))
