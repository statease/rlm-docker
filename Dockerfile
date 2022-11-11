FROM python:3.8-slim

RUN apt-get update -yq \
 && apt-get install -yq \
    curl unzip

RUN curl "https://cdnm.statease.com/support/statease-rlm-linux-x64.tar.gz" -o "rlm.tgz" \
  && tar xzf rlm.tgz --strip-components=1

WORKDIR /statease-rlm

CMD [ "/statease-rlm/rlm" ]