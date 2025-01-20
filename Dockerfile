FROM amazonlinux:2023 AS al2023-base 

# Update and Install Any Dependencies
RUN dnf update \
&& dnf upgrade \
&& dnf install  uuid \
                    openssl \
                    hostname -y
 
 
# Add user/group app with no home for applications run as non-root user
RUN echo app:x:1000 >> /etc/group && \
    echo app:x:1000:1000::/:/bin/bash >> /etc/passwd