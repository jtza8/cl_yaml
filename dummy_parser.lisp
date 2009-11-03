(in-package :yaml)

(defclass dummy-parser (parser)
  ((lines :initform (error "Dummy parser needs lines.")
          :initarg :lines)))

(defmethod fetch-line ((parser dummy-parser))
  (pop (slot-value parser 'lines)))