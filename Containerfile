FROM  quay.io/sclorg/nodejs-20-c9s@sha256:717fa1f2cb017a785f430a243b60c69def35e323c3e945b81583ed258b209c8f AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f33ad316b9c5f8861d80661edcb82d9a865d757615a23a273a2972569cd9e869 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]