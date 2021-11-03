FROM shiftinv/cron

RUN apk add --no-cache curl git openssh jq

ARG GIT_COMMIT
RUN [ -n "$GIT_COMMIT" ] || { echo "\$GIT_COMMIT is not set"; exit 1; }
ENV GIT_COMMIT=$GIT_COMMIT

WORKDIR /workspace
COPY update.sh update.sh
RUN chown user . && chmod +x update.sh
