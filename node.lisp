(in-package :yaml)

(defclass node ()
  ((indent-level :initarg indent-level
                 :accessor indent-level)))