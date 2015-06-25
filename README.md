# hyperkube

a Makefile to build your own hyperkube image

## Summary
This Makefile and Dockerfile can be used to build your own version
of hyperkube.  There is a dependency on the kubernetes source.


## Usage
These directions may help
### Initial git checkouts
```
mkdir -p ~/git/tacodata
cd ~/git/tacodata
git clone https://github.com/tacodata/hyperkube.git
cd ~/git
git clone https://github.com/GoogleCloudPlatform/kubernetes.git
cd tacodata/hyperkube
```
### you need to change tacodata to your docker hub account:
```
make IMAGEACCOUNT=tacodata docker
```
### if you wanted to push this to a different repo (e.g.):
```
make IMAGEACCOUNT=gcr.io/google_containers docker
```
### to make a version other than the current version
```
make IMAGEACCOUNT=tacodata V=v0.18.2 docker
```

## Notes
If make docker works correctly, you will have pushed an image
to docker hub called $TAGROOT/hyperkube:$VERSION

If you do not supply the V flag, the current version is made.  The current version
is calculated from the script:
```
wget -q -O- https://storage.googleapis.com/kubernetes-release/release/latest.txt
```

