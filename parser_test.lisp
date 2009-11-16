(in-package :yaml)

(defparameter *list-lines*
  (list "- one # blah"
        "- two"
        "  - three"
        "    - four"
        "- five"
        "  - six"
        "- seven"))

(defparameter *list-line-one* (make-instance 'line
                                        :indent-level 0
                                        :content "- one"
                                        :comment "blah"))
(defparameter *list-line-two* (make-instance 'line
                                        :indent-level 0
                                        :content "- two"
                                        :comment ""))
(defparameter *list-line-three* (make-instance 'line
                                          :indent-level 1
                                          :content "- three"
                                          :comment ""))
(defparameter *list-line-four* (make-instance 'line
                                          :indent-level 2
                                          :content "- four"
                                          :comment ""))
(defparameter *list-line-five* (make-instance 'line
                                          :indent-level 0
                                          :content "- five"
                                          :comment ""))

(defun assert-lines-equal (expected actual)
  (when (or (eql expected nil) (eql actual nil))
    (assert-equal expected actual)
    (return-from assert-lines-equal))
  (assert-equal (indent-level expected) (indent-level actual))
  (assert-equal (content expected) (content actual))
  (assert-equal (comment expected) (comment actual)))


(defclass parser-test (test-case)
  (parser))

(defmethod set-up :after ((test parser-test))
  (with-slots (parser) test
    (setf parser (make-instance 'dummy-parser :lines *list-lines*))))

(def-test-method test-pre-parse ((test parser-test))
  (with-slots (parser) test
    (assert-lines-equal *list-line-one* (pre-parse parser "- one # blah"))
    (assert-lines-equal *list-line-three* (pre-parse parser "  - three"))
    (assert-lines-equal *list-line-four* (pre-parse parser "    - four"))))

(def-test-method test-advance ((test parser-test))
  (with-slots (parser) test
    (assert-lines-equal nil (past-line parser))
    (assert-lines-equal *list-line-one* (present-line parser))
    (assert-lines-equal *list-line-two* (future-line parser))
    (advance parser)
    (assert-lines-equal *list-line-one* (past-line parser))
    (assert-lines-equal *list-line-two* (present-line parser))
    (assert-lines-equal *list-line-three* (future-line parser))
    (advance parser)
    (assert-lines-equal *list-line-two* (past-line parser))
    (assert-lines-equal *list-line-three* (present-line parser))
    (assert-lines-equal *list-line-four* (future-line parser))
    (advance parser)
    (assert-lines-equal *list-line-three* (past-line parser))
    (assert-lines-equal *list-line-four* (present-line parser))
    (assert-lines-equal *list-line-five* (future-line parser))))


(def-test-method test-parse-list ((test parser-test))
  (with-slots (parser) test
    (assert-equal '("one" "two" ("three" ("four")) "five" ("six") "seven")
                  (parse-list parser))))

(textui-test-run (get-suite parser-test))
