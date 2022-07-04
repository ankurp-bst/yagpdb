set -ex

GIT_BRANCH=$(echo ${GIT_BRANCH}|cut -d'/' -f2)

COMMIT_ID=$(echo ${GIT_COMMIT}| cut -c1-5)

WORKSPACE="${WORKSPACE}@2"

/usr/bin/zip -j $WORKSPACE/${GIT_BRANCH}_${BUILD_NUMBER}_${COMMIT_ID}.zip $WORKSPACE/bin/yagpdb $WORKSPACE/bin/dso-cli $WORKSPACE/bin/shardorchestrator  $WORKSPACE/bin/capturepanics


aws s3 mv $WORKSPACE/${GIT_BRANCH}_${BUILD_NUMBER}_${COMMIT_ID}.zip s3://yagpdb-dev/builds/${GIT_BRANCH}/

echo "${GIT_BRANCH}/${GIT_BRANCH}_${BUILD_NUMBER}_${COMMIT_ID}" >> /home/centos/yagpdb_builds.txt


aws s3 cp /home/centos/yagpdb_builds.txt s3://yagpdb-dev/builds/