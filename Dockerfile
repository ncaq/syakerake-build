FROM fpco/stack-build-small
# apt-getの対話プロンプトを無効化
ENV DEBIAN_FRONTEND noninteractive
# stack-build-smallにはcurlが入っていない
RUN apt-get update && apt-get install -y curl
# nodeを登録
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
# yarnを登録
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
  libpam-cracklib \
  libpq-dev \
  libssl-dev \
  nodejs \
  nullmailer \
  yarn \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
