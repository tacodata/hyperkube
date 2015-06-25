# hyperkube

a Makefile to build your own hyperkube image

## Summary
This Makefile and Dockerfile can be used to build your own version
of hyperkube.  There is a dependency on the kubernetes source.


## Usage
```
mkdir -p ~/git/tacodata
cd ~/git/tacodata
git clone https://github.com/tacodata/hyperkube.git
cd ~/git
git clone https://github.com/GoogleCloudPlatform/kubernetes.git
cd tacodata/hyperkube
vi Makefile
#(change TAGROOT=tacodata to your docker hub repository, of course you will need to create it and login to it on the docker command line)
make docker
```

## Notes
If make docker works correctly, you will have pushed an image
to docker hub called TAGROOT/hyperkube:$VERSION

