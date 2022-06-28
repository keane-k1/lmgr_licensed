FROM centos:8 

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

## 阿里 yum
# RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos8_base.repo

## 腾讯 yum
# RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/$contentdir|baseurl=https://vault.centos.org/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo

RUN yum install -y redhat-lsb-core

WORKDIR /mnt

CMD ["/mnt/x64_lsb/lmgrd", "-c", "/mnt/license_file.lic", "-z"]
