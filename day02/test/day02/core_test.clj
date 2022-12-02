(ns day02.core-test
  (:require [clojure.test :refer :all]
            [day02.core :refer :all]))

(deftest correct
  (testing "q1"
    (is (= (q1) 12794))))
