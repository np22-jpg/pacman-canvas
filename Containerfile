FROM  quay.io/sclorg/nodejs-20-c9s@sha256:6260849b0456cb92f01aaff745eb2ca8b198d5b04eca6b2f3e64dd2d43052660 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:12e95b36ebb242c2dd2f5b02fa05073d2041431722304890e020edea54df5835 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]