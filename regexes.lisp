(in-package :yaml)

(defparameter *comment-regex*
  (ppcre:create-scanner "(.*?(?=\\s*#)|.*)(?:\\s*#\\s*)?(.*)"))

(defparameter *list-item-regex*
  (ppcre:create-scanner "^(\\s*)-(\\s*)(.+?)\\s*$"))

(defparameter *key-value-regex*
  (ppcre:create-scanner "^(\\s*)(.+?)\\s*:\\s*(.+?)\\s*$"))