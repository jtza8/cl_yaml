(in-package :yaml)

(defclass regex-test (test-case)
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

(def-test-method test-list-item-regex ((test regex-test))
  (assert-multiple-regex-captures *list-item-regex*
   '((:expect #("" " " "item" "comment")
      :from "- item #comment")
     (:expect #("    " " " "item" "comment")
      :from "    - item #comment")
     (:expect #("" "  " "item" "comment")
      :from "-  item #comment")
     (:expect nil
      :from "w- item #comment")
     (:expect #("" " " "item" "")
      :from "- item"))))

(def-test-method test-key-value-regex ((test regex-test))
  (assert-multiple-regex-captures *key-value-regex*
   '((:expect #("" "key" "value" "comment")
      :from  "key:value #comment")
     (:expect #("" "key" "value" "comment")
      :from "key : value # comment")
     (:expect #("    " "key" "value" "comment")
      :from "    key : value # comment")
     (:expect #("    " "key" "value" "")
      :from "    key : value"))))

(textui-test-run (get-suite regex-test))