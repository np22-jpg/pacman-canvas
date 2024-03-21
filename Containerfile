FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9deed70c39fa2f945ab43fb8b7f3033745aa2b6c751146f83cc029daceaecc62 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:10552b73acf69851b5ec0fb297b3feb3a7729f551313476b33886fc0e0de60c9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]