FROM google/debian:wheezy

RUN apt-get update
RUN apt-get -yy -q install iptables ca-certificates
COPY hyperkube.tmp /hyperkube
RUN chmod a+rx /hyperkube


COPY master-multi.json.tmp /etc/kubernetes/manifests-multi/master.json
COPY master.json.tmp /etc/kubernetes/manifests/master.json
COPY safe_format_and_mount.tmp /usr/share/google/safe_format_and_mount
RUN chmod a+rx /usr/share/google/safe_format_and_mount
