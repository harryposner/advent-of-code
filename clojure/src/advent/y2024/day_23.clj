(ns advent.y2024.day-23
  (:require [clojure.java.io :as io]
            [clojure.string :as string]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn edges->adjacency
  [edges]
  (reduce (fn [acc [node-1 node-2]]
            (-> acc
                (update node-1 (fnil conj #{}) node-2)
                (update node-2 (fnil conj #{}) node-1)))
          {}
          edges))

(defn n-interconnected
  [adjacency n start-node]
  (let [neighbors (get adjacency start-node)]
    (if (= n 2)
      (into #{}
            (map (fn [nbr] #{start-node nbr}))
            neighbors)
      (into #{}
            (comp (mapcat (partial n-interconnected adjacency (dec n)))
                  (distinct)
                  (remove (fn [connected-set]
                            (or (contains? connected-set start-node)
                                (some (complement neighbors) connected-set))))
                  (map (fn [connected-set] (conj connected-set start-node))))
            neighbors))))

(defn parse
  [input]
  (->> (string/split-lines input)
       (map (fn [line] (string/split line #"-")))))

(defn part-1
  [parsed-input]
  (let [adjacency (edges->adjacency parsed-input)
        nodes (keys adjacency)]
    (transduce (comp (mapcat (partial n-interconnected adjacency 3))
                     (filter (fn [connected-set]
                               (some (fn [node] (= \t (first node))) connected-set)))
                     (distinct))
               (completing (fn [acc _] (inc acc)))
               0
               nodes)))

(defn part-2
  [parsed-input]
  nil)

(defn run
  []
  (let [parsed-input (parse (aocd/input 2024 23))]
    (println "Part 1:" (part-1 parsed-input))
    (println "Part 2:" (part-2 parsed-input))))

(comment
  (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/2024/23.txt"))]
    (is (= 7
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/2024/23.txt"))]
    (is (= "co,de,ka,ta"
           (part-2 (parse example-input))))))
