;;; API for cl-trainspotting
(annot:enable-annot-syntax)
(in-package :lisp-o-motive)

@export
(defclass rail-message () ())
@export
(defclass network-rail-message (rail-message) ())
@export
(defclass network-rail-enquiries-message (rail-message) ())
(defclass real-time-ppm (network-rail-message) ())
@export
(defclass train-describer-message (network-rail-message) ())
@export
(defclass berth-step (train-describer-message)
  ((time :initarg :time)
   (area-id :initarg :area-id)
   (from :initarg :from)
   (to :initarg :to)
   (description :initarg :descr)))
@export
(defclass berth-cancel (train-describer-message)
  ((time :initarg :time)
   (area-id :initarg :area-id)
   (from :initarg :from)
   (description :initarg :descr)))
@export
(defclass berth-interpose (train-describer-message)
  ((time :initarg :time)
   (area-id :initarg :area-id)
   (to :initarg :to)
   (description :initarg :descr)))
@export
(defclass heartbeat (train-describer-message)
  ((time :initarg :time)
   (area-id :initarg :area-id)
   (report-time :initarg :report-time)))
@export
(defclass s-class-mixin (train-describer-message)
  ((time :initarg :time)
   (area-id :initarg :area-id)
   (address :initarg :address)
   (data :initarg :data)))
(defclass signalling-update (s-class-mixin)
  ())
(defclass signalling-refresh (s-class-mixin)
  ())
(defclass signalling-refresh-finished (s-class-mixin)
  ())

(defclass very-short-term-plan (network-rail-message) ())
(defclass temporary-speed-restriction (network-rail-message) ())

@export
(defgeneric message-recieved (message))
;;; private

(defmethod message-recieved ((message train-describer-message))
  (format t "~a~%" message))

