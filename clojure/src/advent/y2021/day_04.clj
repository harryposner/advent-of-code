(ns advent.y2021.day-04
  (:require [clojure.set :as set]
            [clojure.string :as string]
            [aocd.core :as aoc]))

(defn winner?
  [drawn-so-far board]
  (when (some (partial set/superset? drawn-so-far) board)
    board))

(defn score
  [last-number drawn-numbers board]
  (let [board-nums (->> board
                        (take (quot (count board) 2))
                        (apply concat)
                        (into #{}))]
    (->> (set/difference board-nums drawn-numbers)
         (apply +)
         (* last-number))))

(defn part-1
  [draws boards]
  (reduce (fn [drawn-so-far current-draw]
            (let [drawn (conj drawn-so-far current-draw)]
              (if-let [winner (some (partial winner? drawn) boards)]
                (reduced (score current-draw
                                drawn
                                winner))
                drawn)))
          #{}
          draws))

(defn part-2
  [draws boards]
  (reduce (fn [{:keys [drawn-so-far remaining-boards]} current-draw]
            (let [drawn (conj drawn-so-far current-draw)
                  non-winners (filter (complement (partial winner? drawn))
                                      remaining-boards)]
              (if (empty? non-winners)
                (reduced (score current-draw
                                drawn
                                (first remaining-boards)))
                {:drawn-so-far drawn
                 :remaining-boards non-winners})))
          {:drawn-so-far #{}
           :remaining-boards boards}
          draws))

(defn -main
  []
  (let [[draw-line & board-lines] (->> (aoc/input 2021 4)
                                       string/split-lines)
        draws (->> (string/split draw-line #",")
                   (map #(Integer/parseInt %)))
        boards (->> board-lines
                    (map (comp #(string/split % #"\s+") string/trim))
                    (map (fn [line] (when-not (empty? (first line))
                                      (map #(Integer/parseInt %) line))))
                    (drop-while nil?)
                    (reduce (fn [{:keys [boards current-board] :as acc} row]
                              (if (some? row)
                                (update acc :current-board conj row)
                                {:boards (conj boards current-board)
                                 :current-board []}))
                            {:boards []
                             :current-board []})
                    ((fn [{:keys [boards current-board]}]
                       (conj boards current-board)))
                    (map (fn [board] (->> (concat board (apply map vector board))
                                          (map set)))))]
    (println "Part 1: " (part-1 draws boards))
    (println "Part 2: " (part-2 draws boards))))

(comment
  (-main))
