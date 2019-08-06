(defclass train-movements-message (network-rail-message)
  ((source-dev-id :initarg :source-dev-id)
   (user-id :initarg :user-id)
   (original-data-source :initarg :original-data-source)
   (message-queue-timestamp :initarg :msg-queue-timestamp)
   (source-system-id :initarg :source-system-id)))

(defclass train-activation (train-movements-message)
  ((schedule-source :initarg :schedule-source)
   (train-file-address :initarg :train-file-address)
   (schedule-end-date :initarg :schedule-end-date)
   (train-id :initarg :train-id)
   (tp-origin-timestamp :initarg :tp-origin-timestamp)
   (creation-timestamp :initarg :creation-timestamp)
   (tp-origin-stanox :initarg :tp-origin-stanox)
   (origin-departure-timestamp :initarg :origin-dep-timestamp)
   (train-service-code :initarg :train-service-code)
   (train-operating-company-id :initarg :toc-id)
   (d1266-record-number :initarg :d1266-record-number)
   (train-call-type :initarg :train-call-type)
   (train-unique-id :initarg :train-uid)
   (train-call-mode :initarg :train-call-mode)
   (schedule-type :initarg :schedule-type)
   (schedule-origin-stanox :initarg :sched-origin-stanox)
   (schedule-working-timetable-id :initarg :schedule-wtt-id)
   (schedule-start-date :initarg :schedule-start-date)))

(defclass train-cancellation (train-movements-message)
  ((train-file-address :initarg :train-file-address)
   (train-service-code :initarg :train-service-code)
   (origin-location-stanox :initarg :orig-loc-stanox)
   (train-operating-company-id :initarg :toc-id)
   (departure-timestamp :initarg :dep-timestamp)
   (division-code :initarg :division-code)
   (location-stanox :initarg :loc-stanox)
   (cancellation-timestamp :initarg :canx-timestamp)
   (cancellation-reason-code :initarg :canx-reason-code)
   (train-id :initarg :train-id)
   (origin-location-timestamp :initarg :orig-loc-timestamp)
   (cancellation-type :initarg :canx-type)))

(defclass train-movement (train-movements-message)
  ((event-type :initarg :event-type)
   (gbtt-timestamp :initarg :gbtt-timestamp)
   (original-location-stanox :initarg :original-loc-stanox)
   (planned-timestamp :initarg :planned-timestamp)
   (timetable-variation :initarg :timetable-variation)
   (original-location-timestamp :initarg :original-loc-timestamp)
   (current-train-id :initarg :current-train-id)
   (delay-monitoring-point :initarg :delay-monitoring-point)
   (next-report-run-time :initarg :next-report-run-time)
   (reporting-stanox :initarg :reporting-stanox)
   (actual-timestamp :initarg :actual-timestamp)
   (correction-p :initarg :correction-ind)
   (event-source :initarg :event-source)
   (train-file-address :initarg :train-file-address)
   (platform :initarg :platform)
   (division-code :initarg :division-code)
   (train-terminated-p :initarg :train-terminated)
   (train-id :initarg :train-id)
   (offroute-p :initarg :offroute-ind)
   (variation-status :initarg :variation-status)
   (train-service-code :initarg :train-service-code)
   (train-operating-company-id :initarg :toc-id)
   (location-stanox :initarg :loc-stanox)
   (auto-expected-p :initarg :auto-expected)
   (direction :initarg :direction-ind)
   (route :initarg :route)
   (planned-event-type :initarg :planned-event-type)
   (next-report-stanox :initarg :next-report-stanox)
   (line :initarg :line-ind)))

(defclass train-reinstatement (train-movements-message)
  ((current-train-id :initarg :current-train-id)
   (original-location-timestamp :initarg :original-loc-timestamp)
   (train-file-address :initarg :train-file-address)
   (train-service-code :initarg :train-service-code)
   (train-operating-company-id :initarg :toc-id)
   (departure-timestamp :initarg :dep-timestamp)
   (division-code :initarg :division-code)
   (location-stanox :initarg :loc-stanox)
   (train-id :initarg :train-id)
   (original-location-stanox :initarg :original-loc-stanox)
   (reinstatement-timestamp :initarg :reinstatement-timestamp)))

(defclass change-of-origin (train-movements-message)
  ((reason-code :initarg :reason-code)
   (current-train-id :initarg :current-train-id)
   (original-location-timestamp :initarg :original-loc-timestamp)
   (train-file-address :initarg :train-file-address)
   (train-service-code :initarg :train-service-code)
   (train-operating-company :initarg :toc-id)
   (departure-timestamp :initarg :dep-timestamp)
   (change-of-origin-timestamp :initarg :coo-timestamp)
   (division-code :initarg :division-code)
   (location-stanox :initarg :loc-stanox)
   (train-id :initarg :train-id)
   (original-location-stanox :initarg :original-loc-stanox)))

(defclass change-of-identity (train-movements-message)
  ((current-train-id :initarg :current-train-id)
   (train-file-address :initarg :train-file-address)
   (train-service-code :initarg :train-service-code)
   (revised-train-id :initarg :revised-train-id)
   (train-id :initarg :train-id)
   (event-timestamp :initarg :event-timestamp)))

(defclass change-of-location (train-movements-message)
  ((original-location-timestamp :initarg :original-loc-timestamp)
   (current-train-id :initarg :current-train-id)
   (train-file-address :initarg :train-file-address)
   (train-service-code :initarg :train-service-code)
   (departure-timestamp :initarg :dep-timestamp)
   (location-stanox :initarg :loc-stanox)
   (train-id :initarg :train-id)
   (original-location-stanox :initarg :original-loc-stanox)
   (event-timestamp :initarg :event-timestamp)))
