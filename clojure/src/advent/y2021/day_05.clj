(ns advent.y2021.day-05
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn parse
  [input]
  (->> (string/split-lines input)
       (map #(string/split % #" -> "))
       (map (fn [line]
              (->> line
                   (map (fn [point]
                          (->> (string/split point #",")
                               (map parse-long)))))))))

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

(defn part-1
  [lines]
  (let [v-or-h-only (filter (fn [[[x1 y1] [x2 y2]]] (or (= x1 x2) (= y1 y2)))
                            lines)]
    (overlaps v-or-h-only)))

(defn part-2
  [lines]
  (overlaps lines))

(defn run
  []
  (let [parsed-input (parse (aocd/input 2021 5))]
    (println "Part 1:" (part-1 parsed-input))
    (println "Part 2:" (part-2 parsed-input))))

(comment
  (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/2021/05.txt"))]
    (is (= 5
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/2021/05.txt"))]
    (is (= 12
           (part-2 (parse example-input))))))
