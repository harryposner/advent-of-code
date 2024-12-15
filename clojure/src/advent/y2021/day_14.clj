(ns advent.y2021.day-14
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn step
  [rules pair-freqs]
  (reduce (fn [acc [pair n]]
            (if-let [[replacement-1 replacement-2] (get rules pair)]
              (-> acc
                  (update replacement-1 (fnil + 0) n)
                  (update replacement-2 (fnil + 0) n))
              (update acc pair (fnil + 0) n)))
          {}
          pair-freqs))

(defn solve
  [rules template n-steps]
  (let [pair-freqs-init (frequencies (partition 2 1 template))
        pair-freqs-end (-> (iterate (partial step rules) pair-freqs-init)
                           (nth n-steps))
        char-freqs (->> pair-freqs-end
                        (reduce (fn [acc [[_ c2] n]] (update acc c2 (fnil + 0) n))
                                {(first template) 1})
                        (sort-by val))
        least-common (val (first char-freqs))
        most-common (val (last char-freqs))]
    (- most-common least-common)))

(defn -main
  []
  (let [[template rule-lines] (string/split (aoc/input 2021 14) #"\n\n")
        rules (->> (string/split-lines rule-lines)
                   (map (partial re-matches #"([A-Z]{2}) -> ([A-Z])"))
                   (map rest)
                   (map (fn [[k v]] [(vec k) [[(first k) (first v)]
                                              [(first v) (last k)]]]))
                   (into {}))]
    (println (solve rules template 10))
    (println (solve rules template 40))))

(comment
 (-main))
