(in-package :yaml)

(defclass node ()
  ((tag :initform "")
   (content :initform nil)))