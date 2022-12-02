(ns day02.core-test
  (:require [clojure.test :refer :all]
            [day02.core :refer :all]))

(deftest correct
  (is (= (q2) 14979))
  (is (= (q1) 12794)))
