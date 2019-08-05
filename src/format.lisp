(in-package :lisp-o-motive)

(defmethod print-object ((m train-describer-message) stream)
  (print-unreadable-object
   (m stream :type t :identity t)
   (with-slots (time area-id) m
     (format stream "~a ~a"
             (car (cl-strings:split (local-time:format-timestring nil (local-time:unix-to-timestamp
                                                                       (* 1/1000 (parse-integer time))))
                                    #\.))
             (gethash area-id *area-ids*)))))
