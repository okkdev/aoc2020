(ns day2part1
  (:require [clojure.string :as str]))

(defn get-input [file]
  (str/split-lines (slurp file)))

(defn split-colon [line]
  (map #(str/trim %) (str/split line #":")))

(defn parse-input [input]
  (map #(split-colon %) input))

(defn get-value [rule]
  (str/split (first (str/split rule #" ")) #"-"))

(defn get-rules [rule]
  (def rmin (Integer/parseInt (first (get-value rule))))
  (def rmax (Integer/parseInt (last (get-value rule))))
  (def rchar (last (str/split rule #" ")))
  (hash-map :min rmin :max rmax :char rchar))

(defn validate-password [input]
  (def rules (get-rules (first input)))
  (def charcount (count (filter #(= (str %) (get rules :char)) (seq (last input)))))

  (if (and (>= charcount (get rules :min)) (<= charcount (get rules :max)))
    :true :false))

(defn check-passwords [input]
  (for [i input]
    (validate-password i)))

(defn run []
  (def input (get-input "input.txt"))
  (def parsed (parse-input input))
  (println "Matching passwords:" (count (filter #(= % :true) (check-passwords parsed)))))

(run)