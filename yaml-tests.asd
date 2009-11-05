(defsystem "yaml-tests"
  :description "YAML tests"
  :version "0.1"
  :author "Jens Thiede"
  :licence "BSD License"
  :depends-on ("yaml" "xlunit")
  :components ((:file "dummy_parser"
               (:file "parser_test")
               (:file "string_parser_test")
               (:file "regexes_test")))