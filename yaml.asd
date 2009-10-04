(defsystem "yaml"
  :description "A YAML parser and emitter"
  :version "0.1"
  :author "Jens Thiede"
  :licence "BSD"
  :depends-on ("xlunit")
  :components ((:file "packages")
               (:file "node" :depends-on ("packages"))))