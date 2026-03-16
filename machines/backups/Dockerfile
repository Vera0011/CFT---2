FROM ubuntu:noble

COPY html /var/www/html/
COPY src /opt/src/

RUN cd /opt/src/;
RUN chmod 777 prepare.sh;
RUN chmod 777 execute.sh;

RUN ./prepare.sh;

CMD ["bash", "/opt/src/execute.sh"]