(ns advent.core
  (:require [clojure.java.io :as io]
            [clostache.parser :as template]
            [java-time.api :as jt]))

(defn scaffold
  ([day]
   (let [now (jt/zoned-date-time (jt/zone-id "America/New_York"))
         current-year (-> now jt/year .getValue)
         year (if (= (jt/month :december) (jt/month now))
                current-year
                (dec current-year))]
     (scaffold year day)))
  ([year day]
   (let [code (-> (io/resource "template.clj")
                  slurp
                  (template/render {:year (format "%04d" year)
                                    :day (format "%02d" day)}))
         code-file (io/file (format "src/advent/y%04d/day_%02d.clj" year day))
         example-file (io/file (format "resources/examples/%04d/%02d.txt" year day))]
     (io/make-parents example-file)
     (.createNewFile example-file)
     (io/make-parents code-file)
     (when (.createNewFile code-file)
       (with-open [w (io/writer code-file)]
         (.write w code))))))

(comment
  (scaffold 2021 1))