# build the hyperkube image.

# this is the only variable you need to set.
# it can be set on the make command line:
# make IMAGEACCOUNT=mydockerhub
# or with an exported environment variable:
# export IMAGEACCOUNT=mydockerhub
# you can include the repo if not on dockerhub, like:
# make IMAGEACCOUNT=gcr.io/google_containers
#
IMAGEACCOUNT ?= repo/account

# this picks up the latest VERSION.  You can simply
# hard code it if you want to build an older one:
# V=v0.18.2 for example
V ?= $(shell wget -q -O- https://storage.googleapis.com/kubernetes-release/release/stable.txt)

# relative to the cluster directory.  specific files are plucked from there.
# if your git checkout of kubernetes is not in ../../kubernetes,
# then set the variable KUBEROOT
KUBEROOT ?= ../../kubernetes
K=${KUBEROOT}/cluster

H=hyperkube
IMAGENAME = ${IMAGEACCOUNT}/$H

directions :
	@echo 'to make an image for your docker hub account'
	@echo 'make IMAGEACCOUNT=yourdockerhubaccount docker'

all.tmp: $H.tmp safe_format_and_mount.tmp master-multi.json.tmp master.json.tmp
	@echo 'made everything.  you can do a git commit, or make docker'
	touch all.tmp

docker: safe_format_and_mount.tmp master-multi.json.tmp master.json.tmp $H.tmp
	docker build -t ${IMAGENAME}:$V .
	docker push ${IMAGENAME}:$V

master-multi.json.tmp : $K/images/hyperkube/master-multi.json
	sed "s/VERSON/$V/g" $< > $@

master.json.tmp : $K/images/hyperkube/master.json
	sed "s/VERSON/$V/g" $< > $@

$H.tmp:$H.$V.tmp
	rm -f $@
	ln $< $@

$H.$V.tmp:
	curl -s -o $@ https://storage.googleapis.com/kubernetes-release/release/$V/bin/linux/amd64/$H

safe_format_and_mount.tmp : $K/saltbase/salt/helpers/safe_format_and_mount
	cp $K/saltbase/salt/helpers/safe_format_and_mount $@

clean :
	rm -f *.tmp

.PHONY: all
