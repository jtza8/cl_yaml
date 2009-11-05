(in-package :yaml)

(defclass line ()
  ((content :initarg :content
            :initform ""
            :reader content)
   (indent-level :initarg :indent-level
                 :initform 0
                 :reader indent-level)
   (comment :initarg :comment
            :initform ""
            :reader comment)))