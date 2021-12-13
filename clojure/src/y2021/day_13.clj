(ns y2021.day-13
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn fold
  [dots [axis value]]
  (reduce (fn [acc [x y]]
            (conj acc
                  (case axis
                    :x [(if (< x value) x (- value (- x value)))
                        y]
                    :y [x
                        (if (< y value)
                          y
                          (- value (- y value)))])))
          #{}
          dots))

(defn part-1
  [dots folds]
  (count (fold dots (first folds))))

(defn plot-dots
  [dots]
  (let [x-max (apply max (map first dots))
        y-max (apply max (map second dots))
        arr (vec (repeat (inc x-max) (vec (repeat (inc y-max) \space))))]
    (->> dots
         (reduce (fn [acc dot] (assoc-in acc dot \#))
                 arr)
         (apply mapv vector)
         (reduce (fn [lines row] (conj lines (string/join row)))
                 [])
         (string/join \newline))))

(defn part-2
  [dots folds]
  (plot-dots (reduce fold dots folds)))

(defn -main
  []
  (let [[dot-lines fold-lines] (->> (string/split (aoc/input 2021 13) #"\n\n")
                                    (map string/split-lines))
        dots (->> dot-lines
                  (map #(string/split % #","))
                  (map (fn [coords] (mapv #(Integer/parseInt %) coords)))
                  (into #{}))
        folds (->> fold-lines
                   (map (partial re-matches #"fold along (x|y)=(\d+)"))
                   (map rest)
                   (map (fn [[axis value]] [(keyword axis)
                                            (Integer/parseInt value)])))]
    (println (part-1 dots folds))
    (println (part-2 dots folds))))

(comment
  (-main))
