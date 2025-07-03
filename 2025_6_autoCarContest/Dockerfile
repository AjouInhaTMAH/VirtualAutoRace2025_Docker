FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# -------- 기본 패키지 설치 및 로케일 설정 --------
RUN apt update && apt install -y \
    curl gnupg2 lsb-release locales sudo \
    build-essential \
    net-tools \
    git \
    python3-pip \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# -------- ROS GPG 키 등록 및 저장소 추가 --------
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu focal main" \
    > /etc/apt/sources.list.d/ros1.list

# -------- ROS Noetic 설치 --------
RUN apt update && apt install -y ros-noetic-desktop-full

# -------- ROS 환경 설정 --------
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
ENV ROS_PACKAGE_PATH=/root/catkin_ws:/opt/ros/noetic/share

# -------- rosdep 및 ROS 개발 도구 설치 --------
RUN apt install -y \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool

# -------- rosdep 초기화 --------
RUN rosdep init && rosdep update

# -------- catkin 워크스페이스 생성 --------
RUN mkdir -p /root/catkin_ws/src && \
    /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /root/catkin_ws/src && catkin_init_workspace"

# -------- MORAI 메시지 및 예제 패키지 클론 --------
RUN git clone https://github.com/MORAI-Autonomous/MORAI-ROS_morai_msgs.git /root/catkin_ws/src/morai_msgs && \
    git clone https://github.com/MORAI-EDU/beginner_tutorials_blanks.git /root/catkin_ws/src/beginner_tutorials_blanks

# -------- 워크스페이스 빌드 --------
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /root/catkin_ws && catkin_make"

# -------- 추가 ROS 패키지 설치 --------
RUN apt update && apt upgrade -y && \
    apt install -y \
        ros-noetic-rosbridge-server \
        ros-noetic-velodyne

# -------- Python 패키지 설치 --------
RUN pip3 install --no-cache-dir scikit-learn==0.24.1

WORKDIR /root/catkin_ws

# 필수 패키지 설치
RUN apt update && apt install -y \
    curl wget sudo unzip git net-tools iputils-ping vim \
    libgl1 libglx0 libglx-mesa0 libopengl0 \
    libnvidia-gl-535 libnvidia-common-535 libnvidia-compute-535 \
    libx11-dev libgl1-mesa-glx libglib2.0-0 libsm6 libxi6 libxrender1 \
    build-essential x11-apps mesa-utils

# Morai 파일 복사
COPY MoraiLauncher_Lin /opt/MoraiLauncher_Lin

# 작업 디렉토리 설정
WORKDIR /opt/MoraiLauncher_Lin

# 실행 권한 부여
RUN chmod +x MORAISim.sh MoraiLauncher_Lin.x86_64

RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox novnc websockify wget python3 supervisor nano firefox \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# noVNC 설치
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz -O /tmp/novnc.tar.gz && \
    tar -xzf /tmp/novnc.tar.gz -C /opt && \
    mv /opt/noVNC-1.4.0 /opt/noVNC && \
    rm /tmp/novnc.tar.gz

# supervisor 설정 복사
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


WORKDIR /opt/noVNC

EXPOSE 5900 6080

RUN echo "export DISPLAY=:0" >> /root/.bashrc

CMD ["/usr/bin/supervisord", "-n"]