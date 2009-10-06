(in-package :yaml)

(defparameter *list-item-regex*
  (ppcre:create-scanner 
   "^(\\s*)-(\\s*)([\\w\\s]+?(?=\\s*#)|[\\w\\s]+)\\s*#?\\s?(.*)"))

(defparameter *key-value-regex*
  (ppcre:create-scanner 
   "^(\\s*)([\\w\\s]+?)\\s*:\\s*([\\w\\s]+?(?=\\s*#)|[\\w\\s]+)\\s*#?\\s?(.*)"))