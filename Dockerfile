FROM docker.qiudeng.cc/ubuntu:24.04
RUN apt-get update
RUN apt-get install curl -y
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse" > /etc/apt/sources.list \
&& echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse" >> /etc/apt/sources.list \
&& echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-security main restricted universe multiverse" >> /etc/apt/sources.list \
&& echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
&& echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update 
RUN apt-get install -y vim git wget ssh iproute2 gpg
RUN sed -i '1s/^/PermitRootLogin yes\nPubkeyAuthentication yes\nPasswordAuthentication yes\n/' /etc/ssh/sshd_config
RUN service ssh start

# 安装docekr
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin