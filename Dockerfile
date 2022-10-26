FROM ubuntu:latest

# よく使うコマンドをインストール
RUN apt-get update \
    && apt-get install -y \
        sudo \
        wget \
        zip \
        vim \
        git

# Minicondaをセットアップ
WORKDIR /opt
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.11.0-Linux-x86_64.sh \
    && sh /opt/Miniconda3-py38_4.11.0-Linux-x86_64.sh -b -p /opt/miniconda3 \
    && rm -f /opt/Miniconda3-py38_4.11.0-Linux-x86_64.sh
ENV PATH /opt/miniconda3/bin:$PATH

# Pythonのライブラリをインストール
WORKDIR /workspace
COPY requirements.txt /workspace/
RUN pip install -r requirements.txt

# 実行時のコマンドを指定
CMD ["bash"]
