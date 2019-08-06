;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :lisp-o-motive)

(defun frame-body-as-json (frame) (jsown:parse (cl-stomp:frame-body frame)))

(defun parse-train-describer (frame)
  (loop for message in (frame-body-as-json frame)
        collecting (parse-train-describer-message (cadr message))))

(defun lispify-name (name) (cl-strings:replace-all name "_" "-"))

(defun message-alist-to-lambda-list (plist)
  (alexandria:flatten
   (mapcar (lambda (item)
             (cons
              (intern (lispify-name (string-upcase (car item)))
                      (find-package "KEYWORD"))
              (cdr item)))
           plist)))

(let ((message-types
        '(("SF_MSG" . signalling-update)
          ("SG_MSG" . signalling-refresh)
          ("SH_MSG" . signalling-refresh-finished)
          ("CA_MSG" . berth-step)
          ("CB_MSG" . berth-cancel)
          ("CC_MSG" . berth-interpose)
          ("CT_MSG" . heartbeat))))
  (defun parse-train-describer-message (message)
    (let ((type (cdr (assoc (car message) message-types :test #'string=)))
          (message-alist (remove-if (lambda (acons) (string= (car acons) "msg_type")) (cddr message))))
      (apply #'make-instance type (message-alist-to-lambda-list message-alist)))))

(defun clean-frame-body (frame-body)
  (mapcar (lambda (cons-cell)
            (cons (car cons-cell)
                  (if (cdr cons-cell)
                      (cdr cons-cell)
                      "")))
          frame-body))

(let ((message-types
        '(("0001" . train-activation)
          ("0002" . train-cancellation)
          ("0003" . train-movement)
          ("0005" . train-reinstatement)
          ("0006" . change-of-origin)
          ("0007" . change-of-identity)
          ("0008" . change-of-location))))
  (defun parse-train-movement-message (frame)
    (let* ((frame-header (cddadr frame))
           (frame-body (cdr (cdaddr frame)))
           (type (cdr (assoc (cdar frame-header) message-types :test #'string=)))
           (alist (append (cdr frame-header) (clean-frame-body frame-body)))
           (lambda-list (message-alist-to-lambda-list alist)))
      (apply #'make-instance type lambda-list))))

(defun parse-train-movement (frame)
  (loop for message in (frame-body-as-json frame)
        collecting (parse-train-movement-message message)))

(defun process-frame (frame)
  (let ((destination (cl-stomp:get-destination frame)))
    (cond ((cl-strings:starts-with destination "/topic/TD")
           (map nil #'message-recieved (parse-train-describer frame)))
          ((cl-strings:starts-with destination "/topic/TRAIN_MVT")
           (map nil #'message-recieved (parse-train-movement frame)))
          (t nil))))
