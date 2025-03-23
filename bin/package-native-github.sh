#!/usr/bin/env bash

java -version
./mvnw clean package
./mvnw -Pnative -Dagent exec:exec@java-agent -U
./mvnw -Pnative package
basePath=/tmp/download/plugin
mkdir -p ${basePath}
binName=changyan
if [ -f "target/${binName}.exe" ];
then
  echo "window"
  mv "target/${binName}.exe" "${basePath}/${binName}-Windows-$(uname -m).exe"
  exit 0;
fi
if [[ "$(uname -s)" == "Linux" ]];
then
  echo "Linux"
  mv target/${binName} ${basePath}/${binName}-$(uname -s)-$(dpkg --print-architecture).bin
else
  echo "MacOS"
  mv target/${binName} ${basePath}/${binName}-$(uname -s)-$(uname -m).bin
fi