FROM  quay.io/sclorg/nodejs-20-c9s@sha256:114da5f7d93079edaaf80126f979c8ec649924b4908ef20cdc6a93134bedc62e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:49af54014c42064bd51c85794699114e604c791971ccc905143a8ea93277fc4a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]