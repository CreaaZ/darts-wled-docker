# Define build environment for multi-platform builds
FROM --platform=${BUILDPLATFORM} alpine:latest AS build

ARG REF \
    REPOSITORY="lbormann/darts-wled"\
    TARGETPLATFORM
WORKDIR /
RUN apk update && \
    apk add wget tar && \
    case ${TARGETPLATFORM} in \
        "linux/amd64")  DOWNLOAD_ARCH=""  ;; \
        "linux/arm64") DOWNLOAD_ARCH="-arm64"  ;; \
    esac && \
    ASSETNAME="darts-wled$DOWNLOAD_ARCH" && \
    wget "https://github.com/${REPOSITORY}/releases/download/${REF}/$ASSETNAME" && \
    mv $ASSETNAME darts-wled


# Define main container
FROM debian:bookworm-slim
WORKDIR /usr/bin/darts-wled

COPY --from=build /darts-wled ./darts-wled
COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./darts-wled ./entrypoint.sh && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/*

CMD ["./entrypoint.sh"]


