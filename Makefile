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
#V ?= $(shell wget -q -O- https://storage.googleapis.com/kubernetes-release/release/latest.txt)
# version doesn't matter, except for the help message hyperkube returns
V ?= unknown

# relative to the cluster directory.  specific files are plucked from there.
# if your git checkout of kubernetes is not in ../../kubernetes,
# then set the variable KUBEROOT
KUBEROOT ?= ../../kubernetes
K=${KUBEROOT}/cluster

H=hyperkube
IMAGENAME = ${IMAGEACCOUNT}/$H

all.tmp: $(KUBEROOT)/_output/local/bin/linux/amd64/$H
	cp $(KUBEROOT)/_output/local/bin/linux/amd64/$H $H.tmp
	sed "s/VERSION/$V/g" $K/images/hyperkube/master-multi.json > master-multi.json.tmp
	sed "s/VERSION/$V/g" $K/images/hyperkube/master.json > master.json.tmp
	cp $K/saltbase/salt/helpers/safe_format_and_mount safe_format_and_mount.tmp

$(KUBEROOT)/_output/local/bin/linux/amd64/$H :
	(cd $(KUBEROOT); make)

clean :
	rm -f *.tmp *.src

.PHONY: all
