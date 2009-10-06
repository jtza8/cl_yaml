(in-package :yaml)

(defclass node ()
  ((tag :initform ""
        :initarg :tag
        :reader tag)
   (content :initform nil
            :initarg :content
            :reader content)
   (kind :initform nil
         :initarg :kind
         :reader kind)))