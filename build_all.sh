#!/usr/bin/env bash

CURDIR=`/bin/pwd`
BASEDIR=$(dirname $0)
ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)


unset GOPATH

version=`cat ./config/version.go  | grep -i version |cut -d\" -f 2`


cd $CURDIR
bash $ABSDIR/build_package.sh "github.com/deroproject/derohe/cmd/derod"
bash $ABSDIR/build_package.sh "github.com/deroproject/derohe/cmd/explorer"
bash $ABSDIR/build_package.sh "github.com/deroproject/derohe/cmd/dero-wallet-cli"
bash $ABSDIR/build_package.sh "github.com/deroproject/derohe/cmd/dero-miner"
bash $ABSDIR/build_package.sh "github.com/deroproject/derohe/cmd/rpc_examples/pong_server"


for d in build/*; do cp Start.md "$d"; done
cd "${ABSDIR}/build"

#windows users require zip files
#zip -r dero_windows_amd64_$version.zip dero_windows_amd64
zip -r dero_windows_amd64.zip dero_windows_amd64
zip -r dero_windows_x86.zip dero_windows_386
zip -r dero_windows_386.zip dero_windows_386
zip -r dero_windows_amd64_$version.zip dero_windows_amd64
zip -r dero_windows_x86_$version.zip dero_windows_386
zip -r dero_windows_386_$version.zip dero_windows_386

#all other platforms are okay with tar.gz
find . -mindepth 1 -type d -not -name '*windows*'   -exec tar -cvzf {}.tar.gz {} \;
find . -mindepth 1 -type d -not -name '*windows*'   -exec tar -cvzf {}_$version.tar.gz {} \;

cd $CURDIR
