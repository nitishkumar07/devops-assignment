# Bloated and insecure Dockerfile (extra quirks added)
FROM node:18-bullseye as builder

ARG BUILD_ENV=development
ENV NODE_ENV=$BUILD_ENV

WORKDIR /src/app

COPY package.json .
RUN npm install

# Non-standard path to force debugging
COPY . ./src_code

# Stage 2 (runtime) but still as root (bad)
FROM node:18-bullseye

WORKDIR /opt/runtime

COPY --from=builder /src/app/src_code ./

EXPOSE 4567

# Wrong path; will fail unless fixed
CMD ["node", "server.js"]
