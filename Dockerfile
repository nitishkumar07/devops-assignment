# ---------------------
# Stage 1: Build Stage
# --------------------- 
FROM node:18-bullseye AS builder

# Set default argument we can change while building docker image
ARG BUILD_ENV=development
ENV NODE_ENV=$BUILD_ENV

WORKDIR /src/app

COPY package.json .
RUN npm install

# Copy only the code no need to add all files.
COPY app ./src_code

# ----------------------
# Stage 2: Runtime Stage
# ----------------------
FROM node:18-bullseye

# Creating a non root user
RUN useradd -m -u 1001 dev

WORKDIR /opt/runtime

COPY --from=builder /src/app/node_modules ./node_modules
COPY --from=builder /src/app/src_code ./app

# 'dev' user has ownership of the runtime files
RUN chown -R dev:dev /opt/runtime  

WORKDIR /opt/runtime/app

USER dev

EXPOSE 4567

# Use 'node' as the base command to start the application
ENTRYPOINT ["node"] 
CMD ["server.js"]

