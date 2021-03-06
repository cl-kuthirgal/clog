# CLOG - The Common Lisp Omnificent GUI

## David Botton <david@botton.com>

### License BSD 3-Clause License

####
The Common Lisp Omnificient GUI, CLOG for short, uses web technology
to produce graphical user interfaces for applications locally or
remotely, ie as web applications.

Many have asked me -

    Why? or How is this different from X Y Z web framework?

The answer is -

    Why?
           Because more and more a browser "control" or window
           is the only medium you can use to do anything cross
           platform. You are limited to the languages and the
           tools dictated. A GUI framework using the browser
           to render the GUI is the perfect solution.
           
    What's the difference from x or y web framework?

           The best way to understand the difference is look
           through the tutorials and demos, this is a GUI
           framework that happens to use the browser for
           rendering, the internet for remoting your apps etc.
           At the same time your app is already a web app and
           there is no reason not to deploy it (soon) as a
           web "site" also.

View the HTML Documentation:

https://rabbibotton.github.io/clog/clog-manual.html


To load this package and work through tutorials::

1. cd to the CLOG dir (the dir should be one used by QuickLisp ex. ~/common-lisp/)
2. Start emacs/slime or your common lisp "repl" in that directory.
3. In the REPL run:

CL-USER> (ql:quickload :clog)
CL-USER> (load "/Users/dbotton/common-lisp/clog/tutorial/01-tutorial.lisp")
CL-USER> (clog-user:start-tutorial)


Sample CLOG app with code base so far (See tutorial 7 for a video game :) :

```lisp
(defpackage #:clog-user               ; Setup a package for our work to exist in
  (:use #:cl #:clog)                  ; Use the Common Lisp language and CLOG
  (:export start-tutorial))           ; Export as public the start-tutorial function

(in-package :clog-user)               ; Tell the "reader" we are in the clog-user package


;; Define our CLOG application
(defun on-new-window (body)           ; Define the function called on-new-window
  "On-new-window handler."            ; Optional docstring to describe function

  (let ((hello-element                ; hello-element is a local variable that
                                      ; will be bound to our new CLOG-Element
      
      ;; This application simply creates a CLOG-Element as a child to the
      ;; CLOG-body object in the browser window.

      ;; A CLOG-Element represents a block of HTML (we will see later ways to
      ;; directly create buttons and all sorts of HTML elements in more lisp
      ;; like ways with no knowledge of HTML or javascript. 
      (create-child body "<h1>Hello World! (click me!)</h1>")))

    (set-on-click hello-element      ; Now we set a function to handle clicks
          (lambda (obj)              ; In this case we use an anonymous function
            (setf (color hello-element) "green")))

   (run body))) ; Keep our thread alive until connection closes
                ; and prevent garbage collection of our CLOG-Objects
                ; until no longer needed.
            
;; To see all the events one can set and the many properties and styles that
;; exist, take a look through the CLOG manual or the file clog-element.lisp


(defun start-tutorial ()   ; Define the function called start-tutorial
  "Start turtorial."       ; Optional docstring to describe function

  ;; Initialize the CLOG system
  (initialize #'on-new-window)
  ;; Set the function on-new-window to execute
  ;; everytime a browser connection to our app.
  ;; #' tells common lisp to pass the function
  ;; to intialize and not to execute it.


  ;; Open a browser to http://12.0.0.1:8080 - the default for CLOG apps
  (open-browser))
```


Status:

- Connection methods
  - Websockets - DONE
  - (removed long poll method, I can create static web search version with tools)
  - Direct API access to native browser components - to do (not needed but games, soft real-time apps, etc would be perfomance.) 

- HTML bindings and Browser
  - Base system for bindings - DONE
  - Event system - DONE
  - General DOM (Window, Screen, Document, Location, Navigator) - DONE
  - Base Elements (HTML Elements) - DONE
  - Canvas - HTML 5 Canvas bindings - DONE
  - Multimedia - HTML 5 Audio and Video

- CLOG higher level containers and GUI widgets - to do

- Database bindings and server side APIs - to do
  - Current CL packages
  - Direct bidings to widgets ete.

- CLOG Devtools - to do
  - Generate application scaffolding
  - GUI Builder
    - Grid style
    - Page style
  - Electron for native GUIs
  
- Plugins - to do
  - General CL systems
  - Widgets
  
- Documentation - Auto Generated - DONE
