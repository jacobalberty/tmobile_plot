FROM alpine:3.14
RUN apk add --no-cache \
       bash \
       curl \
       gnuplot \
       jq

RUN mkdir -p /scripts
COPY ["tmobile_plot.sh", "plot-cron", "/scripts/"]
RUN chmod 0744 /scripts/tmobile_plot.sh \
    && chmod 0644 /scripts/plot-cron \
    && crontab /scripts/plot-cron \
    && touch /var/log/cron.log

VOLUME /data

CMD crond -b -l 8 && tail -f /var/log/cron.log 
