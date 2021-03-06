;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CLOG - The Common Lisp Omnificent GUI                                 ;;;;
;;;; (c) 2020-2021 David Botton                                            ;;;;
;;;; License BSD 3 Clause                                                  ;;;;
;;;;                                                                       ;;;;
;;;; clog-system.lisp                                                      ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cl:in-package :clog)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Implementation - CLOG System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;
;; initialize ;;
;;;;;;;;;;;;;;;;

(defvar *on-new-window* nil "Store the on-new-window handler")

(defun on-connect (connection-id)
  (when cc:*verbose-output*
    (format t "Start new window handler on connection-id - ~A" connection-id))
  (let ((body (make-clog-body connection-id)))
    (funcall *on-new-window* body)))
    
(defun initialize (on-new-window-handler
		   &key
		     (host           "0.0.0.0")
		     (port           8080)
		     (boot-file      "/boot.html")
		     (static-root    #P"./static-files/"))
  "Inititalize CLOG on a socket using HOST and PORT to serve BOOT-FILE as 
the default route to establish web-socket connections and static files
located at STATIC-ROOT. If CLOG was already initialized and not shut
down, this function does the same as set-on-new-window."
  (if *on-new-window*
      (set-on-new-window on-new-window-handler)
      (progn
	(set-on-new-window on-new-window-handler)
  
	(cc:initialize #'on-connect
		       :host host
		       :port port
		       :boot-file boot-file
		       :static-root static-root))))

;;;;;;;;;;;;;;;;;;;;;;;
;; set-on-new-window ;;
;;;;;;;;;;;;;;;;;;;;;;;

(defun set-on-new-window (on-new-window-handler)
  "Change the on-new-window handler."
  (setf *on-new-window* on-new-window-handler))

;;;;;;;;;;;;;;
;; shutdown ;;
;;;;;;;;;;;;;;

(defun shutdown ()
  "Shutdown CLOG."
  (set-on-new-window nil)
  (cc:shutdown-clog))
