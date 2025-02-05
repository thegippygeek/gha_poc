ARG DOTNET_VERSION=8.0
ARG BASEIMAGE_VERSION=latest
ARG CONTAINER_REGISTRY=ghcr.io

FROM amazonlinux:2023 AS al2023-base 

COPY dnf/dnf.conf /etc/dnf/dnf.conf
COPY ./yum.repos.d /etc/yum.repos.d/

# Update and Install Any Dependencies
RUN dnf update \
    && dnf upgrade \
    && dnf install  uuid \
                    openssl \
                    hostname
 
# Add user/group app with no home for applications run as non-root user
RUN echo app:x:1000 >> /etc/group && \
    echo app:x:1000:1000::/:/bin/bash >> /etc/passwd


FROM ${CONTAINER_REGISTRY}/thegippygeek/gha_poc:${BASEIMAGE_VERSION} AS al2023-dotnet-sdk
ARG DOTNET_VERSION
ENV dotnetversion=dotnet-sdk-$DOTNET_VERSION

# Install dotnet sdk
RUN echo "Installing: " ${dotnetversion}
RUN dnf install $(echo $dotnetversion) \
    && dnf clean all
RUN dotnet --list-sdks

FROM ${CONTAINER_REGISTRY}/thegippygeek/gha_poc:${BASEIMAGE_VERSION} AS al2023-dotnet-runtime
ARG DOTNET_VERSION
ENV dotnetversion=aspnetcore-runtime-$DOTNET_VERSION

# Install aspnet core runtime
RUN echo "Installing: "${dotnetversion}
RUN dnf install $(echo $dotnetversion) \
    && dnf clean all
RUN dotnet --list-runtimes

# nodejs
FROM ${CONTAINER_REGISTRY}/thegippygeek/gha_poc:${BASEIMAGE_VERSION} AS al2023-nodejs

RUN dnf install nodejs \
    && dnf clean all 

# openjdk 17
# al2023-maven-corretto 
