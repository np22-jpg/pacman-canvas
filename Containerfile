FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d6b672a8ce36fdc0e185d6a11e5fdd638c61b56554790b76c8bc713e16b42bdb AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d6bffc83cb9487954b8bfa34b3305d7cfe60c5d2af9297f90deaad9a04bf5dbb AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]