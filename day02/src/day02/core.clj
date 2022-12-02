(ns day02.core
  (:gen-class))


(require '[clojure.string :as str])

(defn parse-char [s]
  (case s
    "A" :a
    "B" :b
    "C" :c
    "X" :x
    "Y" :y
    "Z" :z))

(defn sym->move [s]
  (case s
    :a :rock
    :b :paper
    :c :scissors
    :x :rock
    :y :paper
    :z :scissors))

(defn parse-line [s]
  (mapv parse-char (str/split s #" ")))

(defn parse-lines [s]
  (mapv parse-line s))

(defn move->score [s]
  (case s
    :rock 1
    :paper 2
    :scissors 3))

(defn winner [mine theirs]
  (case [mine theirs]
    [:rock :rock] :tie
    [:paper :paper] :tie
    [:scissors :scissors] :tie
    [:rock :scissors] :win
    [:scissors :paper] :win
    [:paper :rock] :win
    [:scissors :rock] :lose
    [:paper :scissors] :lose
    [:rock :paper] :lose))

(defn sym->winner [s]
  (case s
    :x :lose
    :y :tie
    :z :win))

(defn correct-move [theirs happen]
  (case [theirs happen]
    [:rock :win] :paper
    [:rock :lose] :scissors
    [:rock :tie] :rock
    [:paper :win] :scissors
    [:paper :lose] :rock
    [:paper :tie] :paper
    [:scissors :win] :rock
    [:scissors :lose] :paper
    [:scissors :tie] :scissors))

(defn winner->score [w]
  (case w
    :lose 0
    :tie 3
    :win 6))

(defn get-input []
  (-> "input.txt"
      slurp
      (str/split #"\n")
      parse-lines))

(defn round-score-q1 [their-sym mine-sym]
  (let [their (sym->move their-sym)
        mine (sym->move mine-sym)]
    (+ (winner->score (winner mine their))
       (move->score mine))))

(defn score-rounds-q1 [rounds]
  (mapv #(apply round-score-q1 %) rounds))

(defn round-score-q2 [their-sym happen-sym]
  (let
   [their (sym->move their-sym)
    mine (correct-move their (sym->winner happen-sym))]
    (+ (winner->score (winner mine their))
       (move->score mine))))

(defn score-rounds-q2 [rounds]
  (mapv #(apply round-score-q2 %) rounds))

(defn q1 []
  (->> (get-input)
       score-rounds-q1
       (reduce +)))

(defn q2 []
  (->> (get-input)
       score-rounds-q2
       (reduce +)))


(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Q1: " (q1))
  (println "Q2: " (q2)))
