FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5d5ae04b5c26051506f6d82784fbe285d7b8263f4f3e77b33a60c3a6b715c444 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:49835d1d25a62379746c96d39ccfc7ad1f7b9384f8c55554d9c5e121d20f2ce8 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]