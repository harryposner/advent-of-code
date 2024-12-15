(ns advent.y{{year}}.day-{{day}}
  (:require [clojure.java.io :as io]
            [clojure.test :refer [deftest is]]
            [aocd.core :as aocd]))

(defn parse
  [input]
  input)

(defn part-1
  [parsed-input]
  nil)

(defn part-2
  [parsed-input]
  nil)

(defn run
  []
  (let [parsed-input (parse (aocd/input {{year}} {{day}}))]
    (println "Part 1:" (part-1 parsed-input))
    (println "Part 2:" (part-2 parsed-input))))

(comment
 (run))

(deftest part-1-test
  (let [example-input (slurp (io/resource "examples/{{year}}/{{day}}.txt"))]
    (is (= :replace-with-expected
           (part-1 (parse example-input))))))

(deftest part-2-test
  (let [example-input (slurp (io/resource "examples/{{year}}/{{day}}.txt"))]
    (is (= :replace-with-expected
           (part-2 (parse example-input))))))
