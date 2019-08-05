#|
  This file is a part of lisp-o-motive project.
  Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)
|#

(defsystem "lisp-o-motive-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Selwyn Simsek"
  :license ""
  :depends-on ("lisp-o-motive"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "lisp-o-motive"))))
  :description "Test system for lisp-o-motive"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
