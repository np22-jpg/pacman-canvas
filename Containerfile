FROM  quay.io/sclorg/nodejs-20-c9s@sha256:f43282b46cf5d2596c5ac0faab31c09824c36f020805615d287bf3276d804f70 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:052bb1d3d9a5d2d1a8820da08eec126c55bda8b2c62b55ec2b474392b597cd41 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]