(ns advent.y2021.day-01
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn parse
  [input]
  (->> (string/split-lines input)
       (map parse-long)))

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

(defn run
  []
  (let [parsed-input (parse (aocd/input 2021 1))]
    (println "Part 1:" (part-1 parsed-input))
    (println "Part 2:" (part-2 parsed-input))))

(comment
  (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/2021/01.txt"))]
    (is (= 7
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/2021/01.txt"))]
    (is (= 5
           (part-2 (parse example-input))))))
