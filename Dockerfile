FROM ubuntu:focal
# apt-getの対話プロンプトを無効化, UTF-8を有効化, PATHを通す
ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8 LC_ALL=C.UTF-8 PATH=/root/.local/bin:$PATH
# Nodeなどを取得するためにcurlが必要
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*
# Nodeを登録
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
# Yarnを登録
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# StackとCIに必要になるパッケージをインストール
RUN apt-get update && apt-get install -y \
  ca-certificates \
  gcc \
  git \
  libc6-dev \
  libffi-dev \
  libgmp-dev \
  libpam-cracklib \
  libpq-dev \
  libssl-dev \
  libtinfo-dev \
  make \
  msmtp \
  msmtp-mta \
  netbase \
  nodejs \
  xz-utils \
  yarn \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
# Stackをインストール
RUN curl -sSL https://get.haskellstack.org/ | sh
# CircleCIでは時間がかかりビルドに失敗する可能性すらあるパッケージをインストール
RUN stack --resolver lts-15.4 install classy-prelude-yesod hlint pandoc
