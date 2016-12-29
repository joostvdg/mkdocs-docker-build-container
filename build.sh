#!/bin/bash
TAGNAME="mkdocs-build-img"

echo "# Building new image with tag: $TAGNAME"
docker build --tag=$TAGNAME .
