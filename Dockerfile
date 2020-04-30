FROM ubuntu:xenial
# UTF-8を有効化
ENV LC_ALL C.UTF-8
# apt-getの対話プロンプトを無効化
ENV DEBIAN_FRONTEND noninteractive
# Nodeなどを取得するためにcurlが必要
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*
# Nodeを登録
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
# Yarnを登録
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# StackとCIに必要になるパッケージをインストール
RUN apt-get update && apt-get install -y \
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
  netbase \
  nodejs \
  nullmailer \
  xz-utils \
  yarn \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
# Stackをインストール
RUN curl -sSL https://get.haskellstack.org/ | sh
# CircleCIでは時間がかかりビルドに失敗する可能性すらあるパッケージをインストール
RUN stack --resolver lts-15.4 install \
  Cabal \
  QuickCheck \
  aeson \
  blaze-html \
  bytestring \
  cassava \
  classy-prelude \
  classy-prelude-yesod \
  conduit \
  containers \
  directory \
  email-validate \
  esqueleto \
  fast-logger \
  file-embed \
  filepath \
  foreign-store \
  gravatar \
  hinotify \
  hlint \
  hspec \
  http-conduit \
  mime-mail \
  monad-logger \
  mtl \
  network \
  pandoc \
  pandoc-types \
  persistent \
  persistent-postgresql \
  persistent-template \
  pretty-simple \
  process \
  regex-compat-tdfa \
  shakespeare \
  string-transform \
  template-haskell \
  text \
  time \
  transformers \
  unicode-show \
  unicode-transforms \
  unordered-containers \
  uuid \
  vector \
  wai \
  wai-extra \
  wai-logger \
  warp \
  xml-conduit \
  xss-sanitize \
  yaml \
  yesod \
  yesod-auth \
  yesod-core \
  yesod-form \
  yesod-newsfeed \
  yesod-sitemap \
  yesod-static \
  yesod-test
