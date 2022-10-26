# Docker チュートリアル
## Dockerfileとは
* Dockerfileは，Docker imageの設計図
* Dockerfileを**ビルド**することでDocker imageを作成することができる
* Dockerfileは**テキストファイル**で，１行ごとにコマンドを記載していく
  * OOをインストールする
  * XXのファイルを作成する
## Dockerfileの書き方
1. `FROM`でベースのイメージを指定
2. `COPY/ADD`でビルド時に必要なファイルをイメージにコピー
3. `RUN`でコマンドを実行
4. `CMD`でコンテナを実行するときに動かすコマンドを指定

この流れが基本．あとは「ユーザを追加」，「環境変数を変更」とかもできる．
### FROM
イメージのベースを指定する．Dockerが公式に出しているもの推奨．無駄な機能をもつImageをベースにしてしまうと，Imageのサイズが大きくなってしまう．
```Dockerfile
FROM <Image名>:<タグ名>
```
### COPY/ADD
ビルド時に必要なファイルをホスト（実行しているPC）からコピーする．基本`COPY`推奨．圧縮ファイルをコピーするときには`ADD`を使い，圧縮ファイルが自動で展開される．
```Dockerfile
COPY <ホストのファイル> <コンテナ内のパス>
```
### RUN
**一番良く使う**．コンテナ内でコマンドを実行する．`RUN`を複数書くとその分だけImage Layerが作成されるから最小限にする．やりたいこと１つに対して１行が理想．
`\`で改行．`&&`で複数コマンド．
```Dockerfile
RUN <コマンド1> \
    && <コマンド2>
```
### CMD
Dockerをrunしたときに実行するコマンドを指定．コンテナに入ることが目的でないときに使ったりする．
```
CMD ['コマンド', '引数1', '引数2']
```
## コンテナを実行
### Dockerfileがあるディレクトリに移動する
```
cd docker-tutorial
```
### Docker image をビルドする
```bash
docker build .
```
`docker build <ビルドコンテクスト（context）>`でDocker imageを作成する．
ビルドコンテクストは，基本的にカレントディレクトリ`.`でOK.
### ビルドしたimageをrunしてコンテナに入る
```bash
docker run -it <IMAGE ID>
```
これでコンテナ内に入って開発できる．しかし，開発したファイルはホスト内には保存されない...
### ホストのディレクトリをコンテナにマウント
コンテナを実行する際に，ホストのディレクトリをコンテナにマウントすることができる．こうすることで，ホストとコンテナでファイルを共有することができる．
```bash
docker run -it -v <ホストディレクトリの絶対パス>:<コンテナの絶対パス> <IMAGE ID>
```
コンテナの絶対パスは，`/workspace`などの適当なパスでよい（存在しなくても勝手に作成される）．
