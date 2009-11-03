(in-package :yaml)

(defclass string-parser (parser)
  ())

(defmethod initialize-instance ((parser string-parser) &key string)
  (with-slots ((lines lines)) parser
    (format t string)
    (setf lines (mapcar (lambda (line)
                          (make-instance 'line
                          (ppcre:split *eol-regex* string)))))