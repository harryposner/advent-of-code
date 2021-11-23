(ns y2019.day-02
  (:require [clojure.string :as string]
            [aocd.core :as aoc]))

(defn apply-op [mem ptr]
  (let [[opcode arg1-addr arg2-addr dest] (subvec mem ptr (+ ptr 4))
        op ({1 + 2 *} opcode)
        args (map mem [arg1-addr arg2-addr])]
    (assoc mem dest (apply op args))))

(defn run-intcode
  ([mem]
   (run-intcode mem 0))
  ([mem ptr]
   (let [opcode (mem ptr)]
     (if (= opcode 99)
       (first mem)
       (recur (apply-op mem ptr)
              (+ ptr 4))))))

(defn part-1 [mem]
  (-> mem
      (assoc 1 12, 2 2)
      run-intcode))

(defn goal? [mem noun verb]
  (when (-> mem
            (assoc 1 noun 2 verb)
            run-intcode
            (= 19690720))
    (+ (* 100 noun) verb)))

(defn part-2 [mem]
  (some #(apply (partial goal? mem) %)
        (for [noun (range 100)
              verb (range 100)]
          [noun verb])))

(defn -main
  []
  (let [input (-> (aoc/input 2019 2)
                  string/trim
                  (string/split #",")
                  (as-> $ (map #(Integer/parseInt %) $))
                  vec)]
    (println "Part 1:" (part-1 input))
    (println "Part 2:" (part-2 input))))

(comment
 (-main))
