#!/bin/bash

sudo docker stop shadowsocksr-client
sudo docker rm shadowsocksr-client
sudo docker rmi xjdata/shadowsocksr-client 

sudo docker build -t xjdata/shadowsocksr-client ./