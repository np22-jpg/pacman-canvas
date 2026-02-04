FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2e910446c922a0949be93d2c5756285257ff67db00f83d1918268c564fbc3b02 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ed6a3bc90970e9fedcef4c17efeb3911eabae443cbbfcd8270605525ba65b8fe AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]