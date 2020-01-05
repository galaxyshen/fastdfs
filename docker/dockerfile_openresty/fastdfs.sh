#!/bin/bash

new_val=$FASTDFS_IPADDR
old="com.ikingtech.ch116221"

sed -i "s/$old/$new_val/g" /etc/fdfs/client.conf
sed -i "s/$old/$new_val/g" /etc/fdfs/storage.conf
sed -i "s/$old/$new_val/g" /etc/fdfs/mod_fastdfs.conf

cat  /etc/fdfs/client.conf > /etc/fdfs/client.txt
cat  /etc/fdfs/storage.conf >  /etc/fdfs/storage.txt
cat  /etc/fdfs/mod_fastdfs.conf > /etc/fdfs/mod_fastdfs.txt

mv /usr/local/openresty/nginx/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf.t
cp -r /usr/local/src/lua /usr/local/openresty/nginx/conf/lua
cp /etc/fdfs/nginx.conf /usr/local/openresty/nginx/conf

rm -rf /usr/local/src

echo "start trackerd"
/etc/init.d/fdfs_trackerd start

echo "start storage"
/etc/init.d/fdfs_storaged start

echo "start nginx"
/usr/local/openresty/nginx/sbin/nginx

tail -f  /dev/null