(ns advent.y2021.day-06
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn simulate-fish
  [generations fish-freqs]
  (if (zero? generations)
    fish-freqs
    (recur (dec generations)
           (assoc fish-freqs
                  0 (get fish-freqs 1 0)
                  1 (get fish-freqs 2 0)
                  2 (get fish-freqs 3 0)
                  3 (get fish-freqs 4 0)
                  4 (get fish-freqs 5 0)
                  5 (get fish-freqs 6 0)
                  6 (+ (get fish-freqs 0 0)
                       (get fish-freqs 7 0))
                  7 (get fish-freqs 8 0)
                  8 (get fish-freqs 0 0)))))

(defn parse
  [input]
  (->> (string/split (string/trim input) #",")
       (map #(Integer/parseInt %))
       (frequencies)))

(defn part-1
  [fishies]
  (->> (simulate-fish 80 fishies)
       (vals)
       (reduce +)))

(defn part-2
  [fishies]
  (->> (simulate-fish 256 fishies)
       (vals)
       (reduce +)))

(defn run
  []
  (let [fishies (parse (aocd/input 2021 6))]
    (println "Part 1: " (part-1 fishies))
    (println "Part 2: " (part-2 fishies))))

(comment
  (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/2021/06.txt"))]
    (is (= 5934
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/2021/06.txt"))]
    (is (= 26984457539
           (part-2 (parse example-input))))))
