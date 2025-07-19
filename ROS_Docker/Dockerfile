# ROS Noetic 기반 이미지 사용
FROM ros:noetic

ENV DEBIAN_FRONTEND=noninteractive

# 필수 패키지 업데이트 및 설치
RUN apt update && apt install -y \
    python3-pip \
    python3-rosdep \
    ros-noetic-desktop-full \
    ros-noetic-rosbridge-server \
    && rm -rf /var/lib/apt/lists/*

# rosdep 초기화
RUN rosdep update

# ROS 환경 설정
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "alias ss='source ~/catkin_ws/devel/setup.bash'" >> /root/.bashrc
RUN echo "alias rt='rostopic list'" >> /root/.bashrc
# 기본 시작 셸
CMD ["sleep", "infinity"]