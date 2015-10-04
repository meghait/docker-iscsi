FROM debian
RUN apt-get update
RUN apt-get install open-iscsi
RUN mkdir /mnt/storage
WORKDIR /tmp
COPY ./mount-iscsi.sh ./
RUN chmod +x ./mount-iscsi.sh
ENTRYPOINT ["/bin/bash","/tmp/mount-iscsi.sh"]
