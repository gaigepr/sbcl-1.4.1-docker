FROM ubuntu:latest

MAINTAINER Gaige Pierce-Raison <gaige@cyrusbio.com>

WORKDIR /app
ADD . /app

# Install packages
RUN apt-get update && apt-get install -y curl bzip2 make git

# Setup env
ENV SBCL_VERSION 1.4.1
ENV SBCL_ROOT /sbcl
ENV SBCL_HOME /sbcl/lib/sbcl
ENV SBCL_BIN /sbcl/bin
ENV QUICKLISP_DIR /app/quicklisp

# Install sbcl
RUN mkdir /sbcl \
    && curl -sL https://sourceforge.net/projects/sbcl/files/sbcl/${SBCL_VERSION}/sbcl-${SBCL_VERSION}-x86-64-linux-binary.tar.bz2 \
    | bzip2 -d \
    | tar -xf - -C / \
    && cd /sbcl-${SBCL_VERSION}-x86-64-linux \
    && INSTALL_ROOT=${SBCL_ROOT} ./install.sh \
    && rm -rf /sbcl-${SBCL_VERSION}-x86-64-linux

# Download quicklisp
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp
#RUN curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
#RUN gpg --verify quicklisp.lisp.asc quicklisp.lisp
RUN ${SBCL_BIN}/sbcl --load quicklisp.lisp --eval "(progn (quicklisp-quickstart:install :path \"${QUICKLISP_DIR}\") (quit))"

ENTRYPOINT ["${SBCL_BIN}/sbcl", "--load ${QUICKLISP_DIR}/setup.lisp"]
