ARG DEBIAN_TAG

FROM debian:${DEBIAN_TAG}

RUN apt-get update \ 
    && apt-get install -y --no-install-recommends bash curl coreutils ca-certificates libxi6 \
    libxrender-dev libxtst-dev freeglut3-dev \
    libfreetype.so.6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG JDK_PKG
ARG JDK_HOME

COPY "java/${JDK_PKG}" /tmp/jdk.tgz

RUN mkdir -p "$JDK_HOME"; \
      tar --extract --file /tmp/jdk.tgz --directory "$JDK_HOME" --strip-components 1 \
      && update-alternatives --install "/usr/bin/java" "java" "${JDK_HOME}/bin/java" 1 \
      && rm /tmp/jdk.tgz

ARG GROIMP_PKG
ARG GROIMP_VERSION
ARG GROIMP_DIR 
ARG JAVA_XMX

RUN curl --output /tmp/groimp.deb "$GROIMP_PKG" \
    && dpkg -i /tmp/groimp.deb \
    && rm /tmp/groimp.deb
    
