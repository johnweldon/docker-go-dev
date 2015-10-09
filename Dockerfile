FROM phusion/baseimage:latest

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/sshd/down && \
	/etc/my_init.d/00_regen_ssh_host_keys.sh && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -y \
	ack-grep \
	bzr \
	cmake \
	curl \
	g++ \
	git \
	make \
	man-db \
	mercurial \
	nodejs \
	npm \
	oracle-java8-installer \
	python-dev \
	python-pip \
	ssh \
	sudo \
	tmux \
	unzip \
	vim \
	&& \
	ln -s /usr/bin/nodejs /usr/bin/node && npm install -g bower grunt-cli && \
	pip install ipython && \
	rm -rf /var/cache/oracle-jdk8-installer && \
	mkdir /installs && cd /installs && \
	curl -O https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz && \
	tar -C /usr/local -xzvf go1.5.1.linux-amd64.tar.gz && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* \
		/tmp/* /var/tmp/* \
		/installs /root/.npm \
		/var/cache/debconf/*

COPY ssh /root/.ssh/
COPY local /root/

RUN	\
	cd /root && \
	git init && \
	git remote add origin https://github.com/johnweldon/tiny-profile && \
	git fetch && \
	git checkout -t origin/master -f && \
	chmod 700 /root/.ssh && \
	chmod 600 /root/.ssh/* && \
	git submodule update --init --recursive && \
	echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> /root/.local.bashrc && \
	echo 'export GOPATH=/root' >> /root/.local.bashrc && \
	echo 'export PATH=${PATH}:/usr/local/go/bin' >> /root/.local.bashrc && \
	cat /root/.ssh/id_rsa.pub >| /root/.ssh/authorized_keys

RUN \
	GOPATH=/root PATH=/usr/local/go/bin:$PATH vim +GoInstallBinaries +qall && \
	GOPATH=/root PATH=/usr/local/go/bin:$PATH go get gopkg.in/johnweldon/cleanpath.v0 && \
	GOPATH=/root PATH=/usr/local/go/bin:$PATH go get github.com/johnweldon/fmtf && \
	GOPATH=/root PATH=/usr/local/go/bin:$PATH go install gopkg.in/johnweldon/cleanpath.v0/... && \
	GOPATH=/root PATH=/usr/local/go/bin:$PATH go install github.com/johnweldon/fmtf/... && \
	rm -rf /root/pkg/* /root/src/*


