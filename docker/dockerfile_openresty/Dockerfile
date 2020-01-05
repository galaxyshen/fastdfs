# centos 7
FROM centos:7
# 添加配置文件
ADD conf/client.conf /etc/fdfs/
ADD conf/http.conf /etc/fdfs/
ADD conf/mime.types /etc/fdfs/
ADD conf/storage.conf /etc/fdfs/
ADD conf/tracker.conf /etc/fdfs/
ADD fastdfs.sh /home
ADD conf/nginx.conf /etc/fdfs/
ADD conf/mod_fastdfs.conf /etc/fdfs
ADD conf/lua    /usr/local/src/lua

#source COPY
COPY source/GraphicsMagick-1.3.29.tar /usr/local/src

#curl -L https://phoenixnap.dl.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.34/GraphicsMagick-1.3.34.tar.lz > GraphicsMagick-1.3.34.tar.lz \
#curl -L http://78.108.103.11/MIRROR/ftp/GraphicsMagick/1.3/GraphicsMagick-1.3.29.tar.gz > GraphicsMagick-1.3.29.tar.gz \
# run
RUN yum install git gcc gcc-c++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel wget vim libpng libjpeg libpng-devel libjpeg-devel ghostscript libtiff libtiff-devel freetype freetype-devel -y \
  &&    cd /usr/local/src  \
  &&    git clone https://github.com/happyfish100/libfastcommon.git --depth 1        \
  &&    git clone https://github.com/happyfish100/fastdfs.git --depth 1    \
  &&    git clone https://github.com/happyfish100/fastdfs-nginx-module.git --depth 1   \
  &&    wget https://openresty.org/download/openresty-1.15.8.2.tar.gz    \
  &&    tar -zxvf openresty-1.15.8.2.tar.gz     \
  &&    tar -xvf GraphicsMagick-1.3.29.tar      \
  &&    mkdir -p /home/dfs/{tracker,storage}    \
  &&    mkdir /usr/local/GraphicsMagick   \
  &&    cd /usr/local/src/  \
  &&    cd libfastcommon/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd fastdfs/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd openresty-1.15.8.2/  \
  &&    ./configure --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
  &&    make && make install  \
  &&    cd ../  \
  &&    cd GraphicsMagick-1.3.29 \
  &&    ./configure \
  &&    make && make install    \
  &&    chmod +x /home/fastdfs.sh


# export config
VOLUME /etc/fdfs

EXPOSE 22122 23000 8888 80
ENTRYPOINT ["/home/fastdfs.sh"]
