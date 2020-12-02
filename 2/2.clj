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

(defn validate-positions [input rules pos]
  (for [p pos]
    (= (get rules :char) (str (nth (last input) (- (get rules p) 1))))))

(defn validate-password [input]
  (def rules (get-rules (first input)))
  (def positions (validate-positions input rules [:pos1 :pos2]))
  (and (some true? positions) (some false? positions)))

(defn check-passwords [input]
  (for [i input]
    (validate-password i)))

(defn run []
  (def input (get-input "input.txt"))
  (def parsed (parse-input input))
  (println "Matching passwords:" (count (filter true? (check-passwords parsed)))))

(run)