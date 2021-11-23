(ns y2020.day-12
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(def starting-ship-state
  {:location [0 0]
   :heading [1 0]
   :waypoint [10 1]})

(defn parse
  [instruction]
  {:action (first instruction)
   :value (Integer/parseInt (re-find #"\d+" instruction))})

(def compass->vector
  {\N [0 1]
   \E [1 0]
   \S [0 -1]
   \W [-1 0]})

(defn vec-add
  [v1 v2]
  (mapv + v1 v2))

(defn scalar-vec-mul
  [k v]
  (mapv (partial * k) v))

(defn manhattan-distance
  [[x1 y1] [x2 y2]]
  (+ (Math/abs (- x1 x2))
     (Math/abs (- y1 y2))))

(defn move
  [loc heading distance]
  (vec-add loc (scalar-vec-mul distance heading)))

(defn rotate
  [[x y] degrees]
  (case degrees
    0 [x y]
    90 [(- y) x]
    180 [(- x) (- y)]
    270 [y (- x)]))

(defn part-1-action
  [ship {:keys [action value]}]
  (case action
    (\N \S \E \W) (update ship :location move (compass->vector action) value)
    \L (update ship :heading rotate value)
    \R (update ship :heading rotate (mod (- value) 360))
    \F (update ship :location move (:heading ship) value)))

(defn part-2-action
  [ship {:keys [action value]}]
  (case action
    (\N \S \E \W) (update ship :waypoint move (compass->vector action) value)
    \L (update ship :waypoint rotate value)
    \R (update ship :waypoint rotate (mod (- value) 360))
    \F (update ship :location move (:waypoint ship) value)))

(defn -main
  []
  (let [input (map parse (string/split-lines (aoc/input 2020 12)))]
    (println "Part 1:" (-> (reduce part-1-action starting-ship-state input)
                           :location
                           (manhattan-distance [0 0])))
    (println "Part 2:" (-> (reduce part-2-action starting-ship-state input)
                           :location
                           (manhattan-distance [0 0])))))

(comment
 (-main))
