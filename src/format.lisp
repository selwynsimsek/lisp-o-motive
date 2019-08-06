(in-package :lisp-o-motive)

(defun format-timestamp (timestamp)
  (car (cl-strings:split (local-time:format-timestring nil (local-time:unix-to-timestamp
                                                            (* 1/1000 (parse-integer timestamp))))
                         #\.)))
(defmethod print-object ((m train-describer-message) stream)
  (print-unreadable-object
      (m stream :type t :identity t)
    (with-slots (time area-id) m
      (format stream "~a ~a"
              (format-timestamp time)
              (gethash area-id *area-ids*)))))

(defmethod print-object ((m train-movements-message) stream)
  (print-unreadable-object
      (m stream :type t :identity t)
    (with-slots (message-queue-timestamp) m
      (format stream "~a"
              (format-timestamp message-queue-timestamp)))))

(defmethod print-object ((m train-movement) stream)
  (print-unreadable-object
      (m stream :type t :identity t)
    (with-slots (train-id location-stanox message-queue-timestamp) m
      (format stream "~a ~a ~a" 
              (format-timestamp message-queue-timestamp)
              train-id
              (gethash (parse-integer location-stanox)
                       *stanme-codes*)))))
