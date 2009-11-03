(in-package :yaml)
(defparameter *sample-string*
"one
two
  three
  four
    five
six")

(defclass string-parser-test (test-case)
  ())

(def-test-method test-advance ((test string-parser-test))
  (let ((parser (make-instance 'string-parser :string *sample-string*)))
    (assert-equal (past-line parser) nil)
    (assert-equal (present-line parser) "one")
    (assert-equal (future-line parser) "two")
    (advance parser)))


(textui-test-run (get-suite string-parser-test))