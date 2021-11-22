#!/usr/bin/env -S clj -M

(ns advent-of-code.2020.day-13.core
  (:require [clojure.string :as string]))

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

(let [[raw-start raw-schedule] (string/split-lines (slurp "2020/day_13/input.txt"))
        start-time (Integer/parseInt raw-start)
        schedule (->> (string/split raw-schedule #",")
                      (map #(if (= "x" %) nil (Integer/parseInt %))))]
    (println "Part 1:" (part-1 start-time (filter some? schedule))))
