FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9df8ec855ffa33cf1eabf182e6c4203c6d8f48fcc2811ab19d2045b76148f584 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a4dd7593e748466fbfac8e22fc1b14fca01039c2c00843b414566ef2b669cd4b AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]