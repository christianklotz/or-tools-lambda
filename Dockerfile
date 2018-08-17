FROM amazonlinux:latest

ENV PYTHON_VERSION 3.6.1
ENV PYTHON_DOWNLOAD_URL https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
ENV PYTHON_DOWNLOAD_SHA256 aa50b0143df7c89ce91be020fe41382613a817354b33acdc6641b44f8ced3828

ENV PYTHON_BUILD_DIR /tmp/python
ENV PYTHON_INSTALL_DIR /opt/python3


RUN true \
  && yum -q -e 0 -y update || true \
  && yum -q -e 0 -y install deltarpm tar.x86_64 make gzip gunzip gcc zlib-devel openssl-devel bzip2-devel readline-devel findutils zip || true \
  && yum -q -e 0 -y clean all \
  && curl -fsSL "$PYTHON_DOWNLOAD_URL" -o python.tar.gz \
  && echo "$PYTHON_DOWNLOAD_SHA256 python.tar.gz" | sha256sum -c - \
  && mkdir -p "$PYTHON_BUILD_DIR" && tar -C "$PYTHON_BUILD_DIR" -xzf python.tar.gz --strip-components 1; rm python.tar.gz \
  && cd "$PYTHON_BUILD_DIR"; ./configure --prefix="$PYTHON_INSTALL_DIR" \
  && make && make install \
  && ln -s "$PYTHON_INSTALL_DIR/bin/python3" /usr/bin/python3 \
  && ln -s "$PYTHON_INSTALL_DIR/bin/easy_install-3.6" /usr/bin/easy_install3 \
  && ln -s "$PYTHON_INSTALL_DIR/bin/pip3" /usr/bin/pip3 \
  && ln -s "$PYTHON_INSTALL_DIR/bin/pydoc3" /usr/bin/pydoc3 \
  && ln -s "$PYTHON_INSTALL_DIR/bin/pyenv" /usr/bin/pyenv3

