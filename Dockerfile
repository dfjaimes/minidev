FROM alpine:3.11

RUN apk update && apk add --update ca-certificates && \
  apk add --update python3 py-pip && \
  rm /var/cache/apk/*

WORKDIR /app
COPY requirements.txt ./

RUN pip3 install -r ./requirements.txt

COPY simple-service.py /app
RUN chmod 0755 /app/simple-service.py

ENTRYPOINT [ "python3", "./simple-service.py" ]
