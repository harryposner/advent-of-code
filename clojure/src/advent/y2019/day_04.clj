(ns advent.y2019.day-04
  (:require [clojure.string :as str]
            [aocd.core :as aoc]))

(defn digits [n]
  (map #(- (int %) 48) (str n))) ;;; 48 is ascii 0

(defn non-dec? [n]
  (apply <= (digits n)))

(defn run-of-two? [compare-with n]
  (->> n
       digits
       (partition-by identity)
       (map count)
       (some #(compare-with % 2))))

(defn part-1 [[start end]]
  (->> (range start (inc end))
       (filter #(and (non-dec? %) (run-of-two? >= %)))
       count))

(defn part-2 [[start end]]
  (->> (range start (inc end))
       (filter #(and (non-dec? %) (run-of-two? = %)))
       count))

(defn -main
  []
  (let [bounds (-> (aoc/input 2019 4)
                   str/trim
                   (str/split #"-")
                   (as-> $ (map #(Integer/parseInt %) $)))]
    (println "Part 1:" (part-1 bounds))
    (println "Part 2:" (part-2 bounds))))

(comment
  (-main))
