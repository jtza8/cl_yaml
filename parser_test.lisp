(in-package :yaml)

(defclass parser-test (test-case)
  ((list-lines :initform 
               (list "- one # blah"
                     "- two"
                     "  - three"
                     "    - four"
                     "  - five"
                     "- six"))))

(def-test-method test-advance ((test parser-test))
  (with-slots (list-lines) test
    (let ((parser (make-instance 'dummy-parser :lines list-lines)))
      (assert-equal nil (past-line parser))
      (assert-equal "- one # blah" (present-line parser))
      (assert-equal "- two" (future-line parser))
      (advance parser)
      (assert-equal "- one # blah" (past-line parser))
      (assert-equal "- two" (present-line parser))
      (assert-equal "  - three" (future-line parser)))))

(def-test-method test-update-indent-level ((test parser-test))
  (with-slots (list-lines) test
    (let ((parser (make-instance 'dummy-parser :lines list-lines)))
      (assert-equal 0 (indent-level parser))
      (update-indent-level parser "  ")
      (assert-equal 1 (indent-level parser))
      (update-indent-level parser "    ")
      (assert-equal 2 (indent-level parser)))))

(def-test-method test-parse-comment ((test parser-test))
  (with-slots (list-lines) test
    (let ((parser (make-instance 'dummy-parser :lines list-lines)))
      (assert-equal (parse-comment parser)
                    "- one"
                    "Comment parsing failed."))))

(textui-test-run (get-suite parser-test))
