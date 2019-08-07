# lisp-o-motive

![A locomotive](./data/cover-picture.jpg "A locomotive")

A library for accessing the British Network Rail data feeds.  

Find out about them here: [Open Rail Data](https://wiki.openraildata.com/index.php?title=Main_Page)  

This is a work in progress. At the moment the Train Describer and Train Movements feeds are supported.

## Usage
1.  `(ql:quickload :lisp-o-motive)`
 
2.  Ensure you have a Network Rail data feeds account, you can sign up [here](https://datafeeds.networkrail.co.uk/ntrod/login).

3.  Add your data feeds account credentials: 
```lisp
(setf lisp-o-motive::*username* "selwyn@example.com" lisp-o-motive::*passcode* "xxx")
```
You can avoid the hassle of doing this every time by storing your username and passcode in `<project-root>/config`:
```
selwyn@example.com
xxx
```

and lisp-o-motive will read the credentials upon being loaded.

3.  Establish a connection using `(lisp-o-motive::setup-connection)`.

# Installation

Clone to `~/quicklisp/local-projects`.    

There is an [issue](https://gitlab.common-lisp.net/cl-stomp/cl-stomp/commit/bb311b8692bee3b35d5a9c036fa4f56ca7e80862) with the version of cl-stomp in Quicklisp at the time of writing that can prevent connections from being established; you may like to install a recent version of [cl-stomp](https://gitlab.common-lisp.net/cl-stomp/cl-stomp) to `~/quicklisp/local-projects`.

## Author

* Selwyn Simsek (sgs16@ic.ac.uk)

## Copyright
Cover picture:  
By DiverScout at English Wikipedia, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=6802712  
Copyright (c) 2019 Selwyn Simsek (sgs16@ic.ac.uk)
