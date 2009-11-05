(in-package :yaml)

(defclass parser ()
  ((past-line :initform nil :reader past-line)
   (present-line :initform nil :reader present-line)
   (future-line :initform nil :reader future-line)
   (indent-template :initform nil :reader indent-template)
   (indent-level :initform 0 :reader indent-level)))

(defmethod initialize-instance :after ((parser parser) &key)
  (advance parser))

(defmethod pre-parse ((parser parser) line)
  (ppcre:register-groups-bind (white-space text comment) (*pre-parse-regex* line)
    (with-slots (indent-template) parser
      (let ((indent-level 0))
        (if (eq indent-template nil)
            (when (> (length white-space) 0)
              (setf indent-template white-space
                    indent-level 1))
            (setf indent-level
                  (do ((line-indent
                        indent-template
                        (concatenate 'string line-indent indent-template))
                       (indent-level 0 (1+ indent-level)))
                      ((> (length line-indent) (length white-space)) indent-level))))
        (make-instance 'line
                       :indent-level indent-level
                       :content text
                       :comment comment)))))
  
(defmethod advance ((parser parser))
  (with-slots (indent-template past-line present-line future-line) parser
    (let ((next-line (fetch-line parser)))
      (when (eql next-line nil) (return-from advance parser))
      (setf past-line present-line
            present-line future-line
            future-line (pre-parse parser next-line))
      (if (and (eql present-line nil)
               (not (eql future-line nil)))
          (advance parser)
          parser))))

(defgeneric fetch-line (parser)
  (:documentation "This method should produce a line of text for processing"))

(defmethod parse-list ((parser parser))
  (with-slots (past-line present-line future-line) parser
      (advance parser)))