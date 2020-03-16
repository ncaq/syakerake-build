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
