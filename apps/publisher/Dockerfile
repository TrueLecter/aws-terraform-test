FROM node:16.2.0-buster-slim

WORKDIR /opt/publisher
COPY . /opt/publisher/

RUN groupadd --gid 9001 publisher \
    && useradd -M --uid 9001 --no-user-group --group publisher publisher \
    && mkdir /tmp/cache \
    && npm install --cache /tmp/cache --production \
    && rm -rf /tmp/cache \
    && chown publisher:publisher -R /opt/publisher \
    && chmod +x /opt/publisher/entrypoint.sh

USER publisher

ENTRYPOINT ["npm", "start"]