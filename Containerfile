FROM  quay.io/sclorg/nodejs-20-c9s@sha256:6500f27900ce994b28d4afe441001fa5841cfc8d48a4c764db4cbfb28be698cf AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a02923e82e9340c973304eac5cc02e50426c7cb81529388d555e1499ac58113a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]