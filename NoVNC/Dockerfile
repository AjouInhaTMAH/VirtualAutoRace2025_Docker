FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

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

# VNC 비밀번호 설정 (빈 패스워드)
RUN mkdir -p /root/.vnc && x11vnc -storepasswd "inhaajou1!" /root/.vnc/passwd

WORKDIR /opt/noVNC

EXPOSE 5900 6080

CMD ["/usr/bin/supervisord", "-n"]
