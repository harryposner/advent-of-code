(ns advent.y2021.day-06
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

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

(defn -main
  []
  (let [fishies (->> (string/split (string/trim (aoc/input 2021 6)) #",")
                     (map #(Integer/parseInt %))
                     (frequencies))]
    (println "Part 1: " (->> (simulate-fish 80 fishies)
                             (vals)
                             (reduce +)))
    (println "Part 2: " (->> (simulate-fish 256 fishies)
                             (vals)
                             (reduce +)))))

(comment
  (-main))
