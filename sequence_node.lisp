(in-package :yaml)

(defclass sequence-node (node)
  ((children :initform (make-array 1 :adjustable t :fill-pointer 0)
             :reader children)))

(defmethod append-child ((node sequence-node) child)
  (vector-push-extend child (slot-value node 'children))
  (slot-value node 'children))