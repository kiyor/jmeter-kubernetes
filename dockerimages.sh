#!/bin/bash -e

#docker build --tag="kubernautslabs/jmeter-base:latest" -f Dockerfile-base .
#docker build --tag="kubernautslabs/jmeter-master:latest" -f Dockerfile-master .
#docker build --tag="kubernautslabs/jmeter-slave:latest" -f Dockerfile-slave .
#docker build --tag="kubernautslabs/jmeter-reporter" -f Dockerfile-reporter .

namespace=quay.io/kiyor
oldnamespace=kubernautslabs

if [ ! -z $oldnamespace ]; then
	for f in Dockerfile-master Dockerfile-slave jmeter_master_deploy.yaml jmeter_slaves_deploy.yaml jmeter_grafana_reporter.yaml; do
		gsed -i "s|$oldnamespace|$namespace|g" $f
	done
fi

for sub in base master slave reporter; do
	img="$namespace/jmeter-$sub:latest"
	docker build -t $img -f Dockerfile-$sub .
done
for sub in base master slave reporter; do
	img="$namespace/jmeter-$sub:latest"
	echo "docker push $img"
done
