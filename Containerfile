FROM  quay.io/sclorg/nodejs-20-c9s@sha256:94b43f82bb9a0b39447e101baa2fbe2bac5202c49f5b84f938d2e903623f240e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:4169f49cc040b15168d8f9b09828ffa5ae40ec05bf5ed605439ecce7e725f97c AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]