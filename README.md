# VirtualAutoRace2025
VirtualAutoRace2025 가상환경자율주행경진대회의 도커 환경을 세팅하는 공간입니다.

rqt_graph와 같이 gui가 필요한 경우 아래 코드를 작성한다.
```
xhost +local:docker
```
ROS_Docker 폴더에 들어가서 아래 코드를 실행한다.
```
docker build -t ros_noetic_01 .
```
build과 완료될 경우, 아래 코드를 실행하여 도커를 실행한다.
```
docker run -d \
  --name ros_noetic_container \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/dri:/dev/dri \
  -p 9090:9090 \
  -v ??????????????:/root/catkin_ws \
  ros_noetic_01
```
??????????????의 경우 자신이 연동하고 싶은 폴더를 연동할 수 있다. 이는 github 폴더(pwd로 확인 가능)와 연동하면 된다.
VS코드의 확장자를 이용하여 도커 컨테이너에 접속하면된다.
해당 도커 파일은 간단하게 필수 패키지만 들어가 있습니다. 필요한 경우 따로 패키지를 설치해야합니다.
또한 /root/catkin_ws 위치와 git 폴더가 연동되어 있는 것을 기본으로 하고 있습니다.(???에 git 폴더 위치 넣으면 됨) 
그러므로 추가적인 내용은 따로 설치하여야합니다.

2개의 축약어가 있습니다.
```
ss='source ~/catkin_ws/devel/setup.bash'
rt='rostopic list' 
```
위 내용은 각각 배쉬 실행과 토픽 list를 확인하는 것입니다.
