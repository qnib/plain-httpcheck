FROM qnib/alplain-golang

WORKDIR /usr/local/src/github.com/qnib/plain-httpcheck
COPY main.go .
RUN go get -d \
 && go build

FROM qnib/alplain-init

COPY --from=0 /usr/local/src/github.com/qnib/plain-httpcheck/plain-httpcheck /usr/local/bin/
RUN apk --no-cache add curl
HEALTHCHECK --interval=5s --retries=15 --timeout=2s \
  CMD /usr/local/bin/healthcheck.sh
COPY opt/qnib/entry/*.sh /opt/qnib/entry/
CMD ["plain-httpcheck"]
