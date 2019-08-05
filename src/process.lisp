(in-package :lisp-o-motive)

(defvar *current-message*)

(defun frame-body-as-json (frame)
  (jsown:parse (cl-stomp:frame-body frame)))

(defun parse-train-describer (frame)
  (loop for message in (frame-body-as-json frame)
        collecting
        (parse-train-describer-message (cadr message))))

(defun lispify-name (name)
  (cl-strings:replace-all name "_" "-"))

(defun message-alist-to-lambda-list (plist)
  (alexandria:flatten
   (mapcar (lambda (item)
             (cons (intern (lispify-name (string-upcase (car item)))
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
    (let ((type (cdr (assoc (car message)
                            message-types
                            :test #'string=)))
          (message-alist (remove-if (lambda (acons)
                                      (string= (car acons) "msg_type")) 
                                    (cddr message))))
      (apply #'make-instance type (message-alist-to-lambda-list message-alist)))))

(defun process-frame (frame)
  (setf *current-message* frame)
  (let ((destination (cl-stomp:get-destination frame)))
    (cond ((cl-strings:starts-with destination "/topic/TD")
           (mapcar #'message-recieved (parse-train-describer frame)))
          (t nil))))
