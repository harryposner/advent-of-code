(ns advent.y2020.day-13
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn part-1
  [start schedule]
  (let [bus (apply max-key #(mod (dec start) %) schedule)]
    (* bus (- bus (mod start bus)))))

(defn validate-part-2
  [schedule start-time]
  (cond
    (empty? schedule)
    true
    (or (nil? (first schedule))
        (zero? (mod start-time (first schedule))))
    (recur (rest schedule) (inc start-time))
    :else
    false))

(defn -main
  []
  (let [[raw-start raw-schedule] (string/split-lines (aoc/input 2020 13))
        start-time (Integer/parseInt raw-start)
        schedule (->> (string/split raw-schedule #",")
                      (map #(if (= "x" %) nil (Integer/parseInt %))))]
    (println "Part 1:" (part-1 start-time (filter some? schedule)))))

(comment
 (-main))
