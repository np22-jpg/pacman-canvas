FROM  quay.io/sclorg/nodejs-20-c9s@sha256:169bb287f94072f26ca39992ca58b81ad397152d5946d8a524b7de1efcb67514 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:17678c1c02ad0cbe02717300882455307af4648dd027fdf844462c4ea32adc86 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]