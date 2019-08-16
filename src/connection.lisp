;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cl-annot:enable-annot-syntax)
(in-package :lisp-o-motive)
@export
(defvar *host* "datafeeds.networkrail.co.uk")
@export
(defvar *port* 61618)
@export
(defvar *username*
  (car
   (cl-strings:split
    (alexandria:read-file-into-string (project-relative-pathname #p"../config")) #\Newline)))
@export
(defvar *passcode*
  (cadr
   (cl-strings:split
    (alexandria:read-file-into-string (project-relative-pathname #p"../config")) #\Newline)))
@export
(defun make-connection ()
  (cl-stomp:make-connection *host* *port*))
@export
(defun start-connection (connection &key (passcode *passcode*) (username *username*))
  (cl-stomp:start connection :passcode passcode :username username))
@export
(defun topics () '(;"/topic/TD_WESS_SIG_AREA"
                   ;"/topic/TRAIN_MVT_EX_TOC"
                   "/topic/TRAIN_MVT_ALL_TOC"))
@export
(defun setup-connection ()
  (let ((connection (make-connection)))
    (map nil (lambda (topic) (stomp:register connection #'process-frame topic)) (topics))
    (start-connection connection)))
