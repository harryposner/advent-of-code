(ns advent.y2021.day-12
  (:require [clojure.set :as set]
            [clojure.string :as string]
            [aocd.core :as aoc]))

(defn lower-case?
  [string]
  (every? #(Character/isLowerCase %) string))

(defn all-paths
  [edges trail visited-small allow-second-visit?]
  (let [current-node (first trail)]
    (if (= current-node "end")
      [trail]
      (mapcat (fn [next-node] (all-paths edges
                                         (cons next-node trail)
                                         (if (lower-case? next-node)
                                           (conj visited-small next-node)
                                           visited-small)
                                         (if (contains? visited-small next-node)
                                           false
                                           allow-second-visit?)))
              (if allow-second-visit?
                (get edges current-node)
                (set/difference (get edges current-node)
                                visited-small))))))

(defn part-1
  [edges]
  (count (all-paths edges '("start") #{"start"} false)))

(defn part-2
  [edges]
  (count (all-paths edges '("start") #{"start"} true)))

(defn -main
  []
  (let [edges (->> (string/split-lines (aoc/input 2021 12))
                   (map #(string/split % #"-"))
                   (mapcat (fn [edge] [edge (reverse edge)]))
                   (filter (fn [[_ to]] (not= to "start")))
                   (filter (fn [[from _]] (not= from "end")))
                   (reduce (fn [acc [from to]]
                             (update acc
                                     from
                                     (fnil conj #{})
                                     to))
                           {}))]
    (println (part-1 edges))
    (println (part-2 edges))))

(comment
  (-main))
