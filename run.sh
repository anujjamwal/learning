#!/bin/bash

DIR=$(cd "$(dirname "$0")"; pwd)

if [ "$1" == "tensorflow" ]; then
	docker run -it -p 8888:8888 -v "${DIR}:/notebooks/$(dirname '$0')"  gcr.io/tensorflow/tensorflow:latest-py3
elif [ "$1" == "haskell" ]; then
	docker run -it --volume ${DIR}:/notebooks --publish 8888:8888 gibiansky/ihaskell:latest
else
	docker run -i -t -p 8888:8888 -v "${DIR}:/opt/notebooks" continuumio/anaconda3 \
  	/bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && \
  	/opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks \
  	--ip='*' --port=8888 --no-browser"
fi
