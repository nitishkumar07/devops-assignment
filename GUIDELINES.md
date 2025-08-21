# Internal Deployment Guidelines (Read Me)

1. Default container port should match `APP_PORT` from environment variables.
2. Avoid absolute paths in Docker COPY; use relative paths from the context root.
3. ConfigMaps should be mounted as files unless justified.
4. Probes must use `/status` endpoint (not `/health`).
5. Image tags must follow `appname-buildnumber`.
6. Do not store secrets in Kubernetes Secrets; use external vault/manager.
