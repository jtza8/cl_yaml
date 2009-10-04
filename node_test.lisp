(in-package :yaml)

(defclass node-test (test-case)
  ())

(def-test-method conversion-test ((test node-test))
  (assert-equal 1 2))

(textui-test-run (get-suite node-test))