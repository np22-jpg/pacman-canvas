FROM  quay.io/sclorg/nodejs-20-c9s@sha256:0807440859f8c46de47a304f03e579eeb97272fd630c92d9695a2fdfb46da7d8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:77ea31682c8f16a2bb4a480cf659efe7e4661aeeec97ff053ecdb2797f6584af AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]