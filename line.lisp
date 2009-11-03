(in-package :yaml)

(defclass line ()
  ((content :initarg :content
            :initform ""
            :reader content)
   (indentation :initarg :indentation
                :initform 0
                :reader indentation)
   (comment :initarg :comment
            :initform ""
            :reader comment)))