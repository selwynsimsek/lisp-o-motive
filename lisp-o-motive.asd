#|
  This file is a part of lisp-o-motive project.
  Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)
|#

#|
  Author: Selwyn Simsek (sgs16@ic.ac.uk)
|#

(defsystem "lisp-o-motive"
  :version "0.1.0"
  :author "Selwyn Simsek"
  :license ""
  :depends-on (:cl-stomp
               :jsown
               :cl-strings
               :local-time
               :cl-csv)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "data")
                 (:file "connection" :depends-on ("data"))
                 (:file "process")
                 (:file "api")
                 (:file "train-movements" :depends-on ("api"))
                 (:file "format" :depends-on ("api" "train-movements")))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "lisp-o-motive-test"))))
