# sbcl-1.4.1-docker
A docker container that installs sbcl-1.4.1 and quicklisp.

## Use
`docker run -it gaigepr/sbcl-1.4.1`

## Notes
The Docker file explains what is happening for setup:
* SBCL 1.4.1 is installed from sbcl.org
* Quicklisp is installed. A load directive is in `sbclrc.lisp` so that sbcl will load quicklisp.
* `sbcl --userinit sbclrc.lisp --load main.lisp`

## Debugging the container
The rebuild.sh gives a nice build and test loop. Simply run `./rebuild.sh` to build and run the container interactively.
