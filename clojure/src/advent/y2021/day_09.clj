(ns advent.y2021.day-09
  (:require [aocd.core :as aoc]
            [clojure.string :as string]))

(defn neighbors
  [[ubound-x ubound-y] [x y]]
  (for [[dx dy] [[1 0] [0 1] [-1 0] [0 -1]]
        :let [new-x (+ x dx)
              new-y (+ y dy)]
        :when (and (< new-x ubound-x)
                   (<= 0 new-x)
                   (< new-y ubound-y)
                   (<= 0 new-y))]
    [new-x new-y]))

(defn low-points
  [heightmap]
  (let [ubound-x (count heightmap)
        ubound-y (count (first heightmap))]
    (for [x (range ubound-x)
          y (range ubound-y)
          :let [height (get-in heightmap [x y])]
          :when (every? (fn [[x2 y2]] (< height (get-in heightmap [x2 y2])))
                        (neighbors [ubound-x ubound-y] [x y]))]
      [x y])))

(defn part-1
  [heightmap]
  (->> (low-points heightmap)
       (map (partial get-in heightmap))
       (map inc)
       (reduce +)))

(defn basin
  [heightmap low-point]
  (let [ubound-x (count heightmap)
        ubound-y (count (first heightmap))]
    (loop [seen #{}
           stack (list low-point)]
      (if (empty? stack)
        seen
        (let [point (first stack)
              new-neighbors (->> (neighbors [ubound-x ubound-y] point)
                                 (remove seen)
                                 (filter #(< (get-in heightmap %) 9)))]
          (recur (conj seen point)
                 (concat new-neighbors (rest stack))))))))

(defn part-2
  [heightmap]
  (->> (low-points heightmap)
       (map (comp count (partial basin heightmap)))
       (sort-by -)
       (take 3)
       (reduce *)))

(defn -main
  []
  (let [heightmap (->> (string/split-lines (aoc/input 2021 9))
                       (mapv (fn [line] (mapv #(- (int %) 48) line))))]
    (println (part-1 heightmap))
    (println (part-2 heightmap))))

(comment
  (-main))
