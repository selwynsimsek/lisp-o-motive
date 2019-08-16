;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :lisp-o-motive)
(cl-annot:enable-annot-syntax)
(defun project-base-directory ()
  (make-pathname :defaults #.(or *compile-file-truename* *load-truename*)
                 :type nil :name nil :version nil))

(defun project-relative-pathname (relative-spec)
  (truename (merge-pathnames relative-spec (project-base-directory))))

(defun stanme-csv-pathname () (project-relative-pathname #p"../data/stanme-codes.csv"))
@export
(defvar *stanme-codes*
  (let ((raw (cl-csv:read-csv (stanme-csv-pathname) :skip-first-p t))
        (hash-table (make-hash-table)))
    (map nil (lambda (row) (setf (gethash (parse-integer (first row))
                                          hash-table)
                                 (second row))) raw)
    hash-table))

(defun area-ids-pathname () (project-relative-pathname #p"../data/area-ids.csv"))
@export
(defvar *area-ids*
  (let ((raw (cl-csv:read-csv (area-ids-pathname) :skip-first-p t))
        (hash-table (make-hash-table :test #'equal)))
    (map nil (lambda (row)
               (setf (gethash (car row) hash-table)
                     (cadr row)))
         raw)
    hash-table))

(defun berth-data-pathname ()
  (project-relative-pathname #p"../data/out.json"))

(defun berth-data ()
  (cdr (jsown:parse (alexandria:read-file-into-string (berth-data-pathname)))))
