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


FROM docker.io/thegippygeek/gha_poc_base:feature-workflows_base AS al2023-dotnet8

ARG DOTNET_VERSION
ENV dotnetversion=dotnet-sdk-$DOTNET_VERSION

# Install dotnet sdk
RUN echo "Installing: " ${dotnetversion}
RUN dnf remove 'dotnet*' 'aspnet*' 'netstandard*' \
&& dnf install $(echo $dotnetversion) \
&& dnf clean all
RUN dotnet --list-sdks