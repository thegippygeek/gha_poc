ARG DOTNET_VERSION=8

FROM amazonlinux:2023 AS al2023-base 

COPY ./yum.repos.d /etc/yum.repos.d/

# Update and Install Any Dependencies
RUN dnf update \
&& dnf upgrade \
&& dnf install  uuid \
                    openssl \
                    hostname -y
 
 
# Add user/group app with no home for applications run as non-root user
RUN echo app:x:1000 >> /etc/group && \
    echo app:x:1000:1000::/:/bin/bash >> /etc/passwd


FROM al2023-base AS al2023-dotnet-sdk

ARG DOTNET_VERSION
ENV dotnetversion=dotnet-sdk-$DOTNET_VERSION

# Install dotnet sdk
RUN echo "Installing: " ${dotnetversion}
RUN dnf install $(echo $dotnetversion) -y\
&& dnf clean all
RUN dotnet --list-sdks


FROM al2023-base AS al2023-dotnet-runtime
ARG DOTNET_VERSION
ENV dotnetversion=aspnetcore-runtime-$DOTNET_VERSION

# Install aspnet core runtime
RUN echo "Installing: "${dotnetversion}
RUN dnf install $(echo $dotnetversion) -y \
&& dnf clean all
RUN dotnet --list-runtime