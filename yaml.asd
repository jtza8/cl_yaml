(defsystem "yaml"
  :description "A YAML parser and emitter"
  :version "0.1"
  :author "Jens Thiede"
  :licence "BSD License"
  :depends-on ("xlunit" "cl-ppcre")
  :components ((:file "packages")
               (:file "regexes" :depends-on ("packages"))
               (:file "line" :depends-on ("packages"))
               (:file "parser" :depends-on ("packages" "line" "regexes"))))
