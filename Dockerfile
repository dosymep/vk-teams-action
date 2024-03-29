FROM alpine:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN apk update && apk add curl

WORKDIR /workspace
ENTRYPOINT ["/entrypoint.sh"]