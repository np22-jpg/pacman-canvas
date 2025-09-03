FROM  quay.io/sclorg/nodejs-20-c9s@sha256:935db93a331df250b75dd9385933ece792920b25027d03c7318a940a2789839a AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b7cda68a8fc6c4a84e6db28ed1277e7d3034e670e8d6a01a6bf0dc4abbafac1e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]