(ns y2021.day-05
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn endpoints->all-points
  [[[x1 y1] [x2 y2]]]
  (cond
    (= x1 x2) (map vector (repeat x1) (range (min y1 y2) (inc (max y1 y2))))
    (= y1 y2) (map vector (range (min x1 x2) (inc (max x1 x2))) (repeat y1))
    :else (map vector
               ((if (< x1 x2) identity reverse)
                (range (min x1 x2) (inc (max x1 x2))))
               ((if (< y1 y2) identity reverse)
                (range (min y1 y2) (inc (max y1 y2)))))))

(defn overlaps
  [lines]
  (->> lines
       (mapcat endpoints->all-points)
       (frequencies)
       (filter (fn [[_ n]] (<= 2 n)))
       (count)))

(defn -main
  []
  (let [lines (->> (string/split (aoc/input 2021 5) #"\n")
                   (map #(string/split % #" -> "))
                   (map (fn [line]
                          (->> line
                               (map (fn [point]
                                      (->> (string/split point #",")
                                           (map #(Integer/parseInt %)))))))))
        v-or-h-only (filter (fn [[[x1 y1] [x2 y2]]] (or (= x1 x2) (= y1 y2)))
                            lines)]
    (println "Part 1: " (overlaps v-or-h-only))
    (println "Part 2: " (overlaps lines))))

(comment
  (-main))
