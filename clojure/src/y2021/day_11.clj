(ns y2021.day-11
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn neighbors
  [ubound-x ubound-y x y]
  (for [dx [-1 0 1]
        dy [-1 0 1]
        :when (not= dx dy 0)
        :let [new-x (+ x dx)
              new-y (+ y dy)]
        :when (and (<= 0 new-x)
                   (< new-x ubound-x)
                   (<= 0 new-y)
                   (< new-y ubound-y))]
    [new-x new-y]))

(def ^:const already-flashed -1)

(defn flash
  [octopuses]
  (let [ubound-x (count octopuses)
        ubound-y (count (first octopuses))
        neighbors (partial neighbors ubound-x ubound-y)]
    (if-not (some (fn [row] (some (partial < 9) row))
                  octopuses)
      octopuses
      (recur (loop [octopuses octopuses
                    x 0
                    y 0]
               (cond
                 (= x ubound-x) (recur octopuses 0 (inc y))
                 (= y ubound-y) octopuses
                 (< 9 (get-in octopuses [x y]))
                 (reduce (fn [acc [dx dy]]
                           (update-in acc [dx dy]
                                      (fn [x] (if (not= x already-flashed)
                                                (inc x)
                                                x))))
                         (assoc-in octopuses [x y] already-flashed)
                         (neighbors x y))
                 :else (recur octopuses (inc x) y)))))))

(defn replace-nested
  [smap coll-or-elt]
  (if (seqable? coll-or-elt)
    (mapv #(replace-nested smap %) coll-or-elt)
    (get smap coll-or-elt coll-or-elt)))

(defn countif-nested
  [pred coll-or-elt]
  (if (seqable? coll-or-elt)
    (->> coll-or-elt
         (map (partial countif-nested pred))
         (reduce +))
    (if (pred coll-or-elt) 1 0)))

(defn step
  [{:keys [octopuses n-flashes]}]
  (let [new-octopuses (->> octopuses
                           (mapv (partial mapv inc))
                           flash
                           (replace-nested {already-flashed 0}))]
    {:octopuses new-octopuses
     :n-flashes (+ n-flashes
                   (countif-nested zero? new-octopuses))}))

(defn part-1
  [octopuses]
  (:n-flashes (nth (iterate step {:octopuses octopuses
                                  :n-flashes 0})
                   100)))

(defn part-2
  [octopuses]
  (->> (iterate step {:octopuses octopuses :n-flashes 0})
       (map-indexed vector)
       (some (fn [[i {:keys [octopuses]}]]
               (when (->> octopuses
                          (apply concat)
                          (every? zero?))
                 i)))))

(defn -main
  []
  (let [octopuses (->> (string/split-lines (aoc/input 2021 11))
                       (map #(string/split % #""))
                       (mapv (fn [row] (mapv #(Integer/parseInt %) row))))]
    (println (part-1 octopuses))
    (println (part-2 octopuses))))

(comment
 (-main))
