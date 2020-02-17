FROM fpco/stack-build-small

# リポジトリ情報をアップデート
RUN apt-get update
# stack-build-smallにはcurlが入っていない
RUN apt-get install -y curl
# nodeを登録
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
# yarnを登録
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# リポジトリ情報をアップデートして
RUN apt-get update
# 対話プロンプトを無効化して
ENV DEBIAN_FRONTEND noninteractive
# 必要なライブラリをインストール
RUN apt-get install -y nodejs yarn libpam-cracklib nullmailer zlib1g-dev libssl-dev libpq-dev
