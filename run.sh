#!/bin/bash

DIR=$(cd "$(dirname "$0")"; pwd)

docker run -i -t -p 8888:8888 -v "/opt/notebooks:${DIR}" continuumio/anaconda3 \
  /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && \
  /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks \
  --ip='*' --port=8888 --no-browser"
