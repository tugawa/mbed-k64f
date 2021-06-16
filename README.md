# MBed k64f 開発環境 Docker コンテナ

MBed の開発用コンテナ．`home`以下がコンテナ内のホームディレクトリになる．localhost:2422にsshで接続して利用する．

## 使い方

### 0. 前提

`docker`と`docker-compose`が必要．sudoするので，`docker`グループに入っている必要はない．

動作確認は以下の環境

  * Ubuntu 20.04
  * Docker version 20.10.7 (インストール方法は次のセクションを参照)
  * docker-compose version 1.25.0

### 1. ログイン用の ssh 公開鍵の用意

`home/.ssh/authorized_keys` に公開鍵を置く．この鍵を使ってsshでログインすることになる．

### 2. コンテナの起動

```
./run.sh
```

### 3. ログイン

```
ssh -p 2422 localhost
```

### 4. 適当なプロジェクトを作ってビルドしてみる

```
mbed new sample
cd sample
echo "int main(){return 0;}" > main.c
mbed export -m F64K -i make_gcc_arm
make
```

### 5. コンテナの終了

このディレクトリで
```
docker-compose down
```

## Dockerのインストール

```
> sudo apt install apt-transport-https ca-certificates curl software-properties-common
> curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
> sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
> sudo apt update
> sudo apt install docker-ce
```
