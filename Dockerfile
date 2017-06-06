FROM qnib/alplain-init

RUN apk --no-cache add curl wget jq \
 && wget -qO /usr/local/bin/go-github https://github.com/qnib/go-github/releases/download/0.2.2/go-github_0.2.2_MuslLinux \
 && chmod +x /usr/local/bin/go-github \
 && echo "# go-fisherman: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-httpcheck --regex '.*_Alpine' --limit 1)" \
 && wget -qO /usr/local/bin/go-httpcheck "$(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-httpcheck --regex '.*_Alpine' --limit 1)" \
 && chmod +x /usr/local/bin/go-httpcheck \
 && rm -f /usr/local/bin/go-github
HEALTHCHECK --interval=5s --retries=15 --timeout=2s \
  CMD /usr/local/bin/healthcheck.sh
COPY opt/qnib/entry/*.sh /opt/qnib/entry/
COPY opt/healthchecks/20-httpcheck.sh /opt/healthchecks/
CMD ["go-httpcheck"]
