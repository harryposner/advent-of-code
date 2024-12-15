(ns advent.y2022.day-06
  (:require [clojure.java.io :as io]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn solve
  [input window-size]
  (->> input
       (partition window-size 1)
       (map-indexed vector)
       (drop-while (fn [[_ window]] (not= window-size (count (distinct window)))))
       ffirst
       (+ window-size)))

(defn parse
  [input]
  input)

(defn part-1
  [input]
  (solve input 4))

(defn part-2
  [input]
  (solve input 14))

(defn run
  []
  (let [parsed-input (parse (aocd/input 2022 6))]
    (println "Part 1:" (part-1 parsed-input))
    (println "Part 2:" (part-2 parsed-input))))

(comment
  (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/2022/06.txt"))]
    (is (= 11
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/2022/06.txt"))]
    (is (= 26
           (part-2 (parse example-input))))))
