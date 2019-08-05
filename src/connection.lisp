(in-package :lisp-o-motive)

(defun load-config-username ()
  (alexandria:when-let
      ((file (probe-file
               (merge-pathnames
                #p"../config"
                #.(or *compile-file-truename* *load-truename*)))))
    (cl-strings:split (alexandria:read-file-into-string file) #\Newline)))

(defvar *host* "datafeeds.networkrail.co.uk")
(defvar *username*
  (car (cl-strings:split
        (alexandria:read-file-into-string
         (project-relative-pathname #p"../config"))
        #\Newline)))

(defvar *port* 61618)
(defvar *passcode*
  (cadr
   (cl-strings:split
    (alexandria:read-file-into-string
     (project-relative-pathname #p"../config"))
    #\Newline)))

(defun make-connection ()
  (cl-stomp:make-connection *host* *port*))

(defun start-connection (connection &key (passcode *passcode*)
                                         (username *username*))
  (cl-stomp:start connection :passcode passcode :username username))

(defun topics ()
  '("/topic/TD_WESS_SIG_AREA"))

(defun setup-connection ()
  (let ((connection (make-connection)))
    (mapcar (lambda (topic)
              (stomp:register connection #'process-frame topic))
            (topics))
    (start-connection connection)))
