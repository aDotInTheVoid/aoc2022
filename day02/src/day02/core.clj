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
  (mapv sym->move (mapv parse-char (str/split s #" "))))

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

(defn round-score [theirs mine]
  (+ (winner->score (winner mine theirs))
     (move->score mine)))

(defn score-rounds [rounds]
  (mapv #(apply round-score %) rounds))

(defn q1 []
  (->> (get-input)
       score-rounds
       (reduce +)))


(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Q1: " (q1)))
