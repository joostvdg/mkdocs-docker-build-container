#tag 'onbuild' creates a python container and automatically reads requirements.txt to install all dependencies via PIP.
FROM python:onbuild
MAINTAINER Joost van der Griendt <joostvdg@gmail.com>
LABEL authors="Joost van der Griendt <joostvdg@gmail.com>"
LABEL version="1.0.0"
LABEL description="Docker container for building sites with MKDocs"
