# build the hyperkube image.

V=$(shell wget -q -O- https://storage.googleapis.com/kubernetes-release/release/stable.txt)
K=../../kubernetes/cluster
TAGROOT=tacodata
H=hyperkube

all: $H.tmp safe_format_and_mount.tmp master-multi.json.tmp master.json.tmp
	docker build -t ${TAGROOT}/$H:$V .
	rm $H.tmp
	docker push ${TAGROOT}/$H:$V

master-multi.json.tmp : master-multi.json
	sed "s/V/$V/g" $< > $@

master.json.tmp : master.json
	sed "s/V/$V/g" $< > $@

$H.tmp:$H.$V.tmp
	ln $< $@

$H.$V.tmp:
	curl -s -o $@ https://storage.googleapis.com/kubernetes-release/release/$V/bin/linux/amd64/$H

safe_format_and_mount.tmp : 
	cp $K/saltbase/salt/helpers/safe_format_and_mount $@

clean :
	rm -f *.tmp

.PHONY: all
