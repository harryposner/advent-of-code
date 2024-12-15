(ns advent.y2020.day-11
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(def EMPTY \L)
(def OCCUPIED \#)
(def FLOOR \.)

(defn seat-ref [seats row col]
  (-> seats
      (get row)
      (get col)))

(defn valid-coords? [seats row col]
  (and (<= 0 row (dec (count seats)))
       (<= 0 col (dec (count (seats 0))))))

(defn neighbors-part-1 [seats row col]
  (for [dx [-1 0 1]
        dy [-1 0 1]
        :let [[new-row new-col] [(+ row dx) (+ col dy)]]
        :when (and (valid-coords? seats new-row new-col)
                   (not= [dx dy] [0 0]))]
    (seat-ref seats new-row new-col)))

(defn look-in-direction [seats row col dx dy]
  (let [[next-row next-col] [(+ row dx) (+ col dy)]]
    (if (not (valid-coords? seats next-row next-col))
      EMPTY
      (let [next-seat (seat-ref seats next-row next-col)]
        (if (= next-seat FLOOR)
          (recur seats next-row next-col dx dy)
          next-seat)))))

(defn neighbors-part-2 [seats row col]
  (for [dx [-1 0 1]
        dy [-1 0 1]
        :when (not= [dx dy] [0 0])]
    (look-in-direction seats row col dx dy)))

(defn update-seats [neighbors-fn neighbors-threshold current-seats]
  (vec
   (map-indexed
    (fn [row row-seats]
      (vec
       (map-indexed
        (fn [col seat]
          (let [occupied-neighbors (->> (neighbors-fn current-seats row col)
                                        (filter #(= % OCCUPIED))
                                        count)]
            (cond
              (and (= seat EMPTY) (zero? occupied-neighbors))
              OCCUPIED
              (and (= seat OCCUPIED)
                   (>= occupied-neighbors neighbors-threshold))
              EMPTY
              :else seat)))
        row-seats)))
    current-seats)))

(defn count-occupied [seats]
  (->> seats
       flatten
       (filter #(= % OCCUPIED))
       count))

(defn fixed-point [f value]
  (let [next-value (f value)]
    (if (= value next-value)
      value
      (recur f next-value))))

(defn -main
  []
  (let [raw-input (aoc/input 2020 11)
        initial-seats (string/split-lines raw-input)]
    (println "Part 1:"
             (count-occupied (fixed-point
                              (partial update-seats neighbors-part-1 4)
                              initial-seats)))
    (println "Part 2:"
             (count-occupied (fixed-point
                              (partial update-seats neighbors-part-2 5)
                              initial-seats)))))

(comment
 (-main))
