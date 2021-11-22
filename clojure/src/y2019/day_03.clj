(require '[clojure.string :as string]
         '[clojure.set :as set])


(defn distance [[x0 y0] [x1 y1]]
  (+ (Math/abs (- x1 x0))
     (Math/abs (- y1 y0))))

(defn part-1 [wires]
  (->> wires
       (map set)
       (apply set/intersection)
       (map (partial distance [0 0]))
       (apply min)))


(defn path-lengths [coords wire]
  (->> wire
       (keep-indexed (fn [idx elt] (if (coords elt) [elt (inc idx)])))
       (into {})))

(defn part-2 [wires]
  (let [intersections (->> wires
                           (map set)
                           (apply set/intersection))
        combined-distance (->> wires
                               (map (partial path-lengths intersections))
                               (apply (partial merge-with +)))]
    (->> intersections
         (map combined-distance)
         (apply min))))


(defn coord-range [[x0 y0] direction-str]
  (let [heading (first direction-str)
        distance (inc (Integer/parseInt (subs direction-str 1)))
        step (case heading (\U \R) 1, (\D \L) -1)]
    (for [delta (range step (* distance step) step)]
      (case heading
        (\U \D) [x0 (+ y0 delta)]
        (\R \L) [(+ x0 delta) y0]))))

(defn directions->wire
  ([directions]
   (directions->wire directions [[0 0]]))
  ([directions trail]
   (if-let [next-dir (first directions)]
     (recur (rest directions)
            (concat trail
                    (coord-range (last trail) next-dir)))
     (rest trail))))  ;;; The origin doesn't count

(def input
  (->> "input.txt"
      slurp
      string/split-lines
      (map (comp directions->wire #(string/split % #",")))))

(println "Part 1:" (part-1 input))
(println "Part 2:" (part-2 input))
