FROM ubuntu:noble
WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y && \
    apt install nginx openssh-client openssh-server cron nano iproute2 -y

# Installs and configures required packages and project
RUN scripts/prepare.sh && \
    mv /app/scripts/execute.sh /execute.sh && \
    rm -rf /app

WORKDIR /

EXPOSE 80 443 22

CMD ["bash", "/execute.sh"]