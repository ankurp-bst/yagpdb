set -ex
echo $(go env)
echo $(which go)
chmod -R 777 $(pwd)

pwd=$(pwd)
mkdir -p ${pwd}/bin/
export GOBIN=${pwd}/bin/
export GOCACHE="/tmp/" && cd ${pwd}/cmd/yagpdb && go install -ldflags "-X github.com/botlabs-gg/yagpdb/v2/common.VERSION=$(git describe --tags)"
export GOCACHE="/tmp/" && cd ${pwd}/cmd/dso-cli && go install -ldflags "-X github.com/botlabs-gg/yagpdb/v2/common.VERSION=$(git describe --tags)"
cd ${pwd}
VER=$(cat go.mod | egrep -m 1 github.com/botlabs-gg/yagpdb/v2)
VER=`echo $VER | sed -e 's/^[[:space:]]*//'`
VER=`echo ${VER} |sed -e 's/ /@/g'`
echo $VER
echo "/go/pkg/mod/$VER/cmd/shardorchestrator"
cd "/go/pkg/mod/$VER/cmd/shardorchestrator"
go install

cd ${pwd}
cd "/go/pkg/mod/$VER/cmd/capturepanics"
go install
cd ${pwd}
ls -a
export GOCACHE="/tmp/" && go test -v ./...