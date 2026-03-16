FROM ubuntu:noble
WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y && \
    apt install openssh-client openssh-server nano sudo rsync -y

# Installs and configures required packages and project
RUN scripts/prepare.sh && \
    mv /app/scripts/execute.sh /execute.sh && \
    rm -rf /app

WORKDIR /

EXPOSE 22

CMD ["bash", "/execute.sh"]