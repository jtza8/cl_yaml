(in-package :yaml)

(defclass regexes-test (test-case)
  ())

(defun assert-regex-capture (expected target-string regex)
  (multiple-value-bind (match strings)
      (ppcre:scan-to-strings regex target-string)
    (declare (ignore match))
    (assert-true (equalp expected strings)
                 (format nil "expected ~s but got ~s from ~s"
                         expected strings target-string))))

(defun assert-multiple-regex-captures (regex table)
  (dolist (row table)
    (assert-regex-capture (getf row :expect) (getf row :from) regex)))

(def-test-method test-comment-regex ((test regexes-test))
  (assert-multiple-regex-captures *comment-regex*
   '((:expect #("" "comment")
      :from "#comment")
     (:expect #("blah" "comment")
      :from "blah#comment")
     (:expect #("bl ah" "comment")
      :from "bl ah  #  comment")
     (:expect #("bl ah" "")
      :from "bl ah"))))

(def-test-method test-list-item-regex ((test regexes-test))
  (assert-multiple-regex-captures *list-item-regex*
   '((:expect #("" " " "item") :from "- item")
     (:expect #("    " " " "item") :from "    - item ")
     (:expect #("" "  " "item") :from "-  item")
     (:expect nil :from "w- item")
     (:expect #("" "" "") :from "-"))))

(def-test-method test-key-value-regex ((test regexes-test))
  (assert-multiple-regex-captures *key-value-regex*
   '((:expect #("" "key" "value")
      :from  "key:value")
     (:expect #("" "key" "value")
      :from "key : value ")
     (:expect #("    " "key" "value")
      :from "    key : value")
     (:expect #("" "key" "")
      :from "key:"))))

(textui-test-run (get-suite regexes-test))