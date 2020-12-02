(ns day2part2
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
  (def rpos1 (Integer/parseInt (first (get-value rule))))
  (def rpos2 (Integer/parseInt (last (get-value rule))))
  (def rchar (last (str/split rule #" ")))
  (hash-map :pos1 rpos1 :pos2 rpos2 :char rchar))

(defn validate-position [input rules pos]
  (= (get rules :char) (str (nth (last input) (- (get rules pos) 1)))))

(defn validate-password [input]
  (def rules (get-rules (first input)))

  (if (and (validate-position input rules :pos1) (validate-position input rules :pos2))
    :true :false))

(defn check-passwords [input]
  (for [i input]
    (validate-password i)))

(defn run []
  (def input (get-input "input.txt"))
  (def parsed (parse-input input))
  (println "Matching passwords:" (count (filter #(= % :true) (check-passwords parsed)))))

(run)