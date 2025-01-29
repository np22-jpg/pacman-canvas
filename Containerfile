FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ebd11c8de4bab42cc8f2646d799ad23b62b60622ea99bbd0eca880804659aa9c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a7aaad045ab79a666b4a2aad7da70a8bce109efedd79527bfb3e3d29adba594f AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]