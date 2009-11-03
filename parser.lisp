(in-package :yaml)

(defclass parser ()
  ((past-line :initform nil :reader past-line)
   (present-line :initform nil :reader present-line)
   (future-line :initform nil :reader future-line)
   (indent-format :initform nil :reader indent-format)
   (indent-level :initform 0 :reader indent-level)))

(defmethod initialize-instance :after ((parser parser) &key)
  (advance parser))

(defmethod advance ((parser parser))
  (with-slots ((line-buffer line-buffer)
               (past-line past-line)
               (present-line present-line)
               (future-line future-line)) parser
    (let ((next-line (fetch-line parser)))
      (when (eql next-line nil) (return-from advance parser))
      (setf past-line present-line
            present-line future-line
            future-line next-line)
      (if (eql present-line nil)
          (advance parser)
          parser))))

(defgeneric fetch-line (parser)
  (:documentation "This method should produce a line of text for processing"))

(defmethod update-indent-level ((parser parser) white-space)
  (with-slots (indent-format indent-level) parser
    (if (eql indent-format nil)
        (setf indent-format (ppcre:scan-to-strings "^\\s+" white-space)
              indent-level 1)
        (setf indent-level 
              (do ((level 0 (1+ level))
                   (indent indent-format (concatenate 'string indent indent-format))
                  ((> (length indent) (length white-space)) level)))))))

(defmethod parse-comment ((parser parser))
  (with-slots (present-line) parser
    (ppcre:register-groups-bind (text comment) (*comment-regex* present-line)
      (values text comment))))

(defmethod parse-list ((parser parser))
  (with-slots (past-line present-line future-line) parser
      (advance parser)))