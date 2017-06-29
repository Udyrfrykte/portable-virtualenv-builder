FROM centos:6

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
  && yum install -y python-virtualenv tar

ADD package.sh /

CMD ["/package.sh"]
