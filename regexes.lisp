(in-package :yaml)

(defparameter *pre-parse-regex*
  (ppcre:create-scanner "^(\\s*)(.*?(?=\\s*#)|.*)(?:\\s*#\\s*)?(.*)"))

(defparameter *list-item-regex*
  (ppcre:create-scanner "^(\\s*)-(\\s*)(.*?)\\s*$"))

(defparameter *key-value-regex*
  (ppcre:create-scanner "^(\\s*)(.+?)\\s*:\\s*(.*?)\\s*$"))
