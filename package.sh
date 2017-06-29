#! /bin/bash

cat >| requirements.txt

# install build packages that may be needed for pip install
if [ -n "$BUILD_PACKAGES" ]; then
  yum install -y $BUILD_PACKAGES &>/dev/null
fi

# create and activate venv
virtualenv venv &>/dev/null
source venv/bin/activate

# install python packages in the virtual env
pip install --requirement requirements.txt &>/dev/null

# make the virtual env portable (and delete unsupported activate scripts)
virtualenv --relocatable venv &>/dev/null
sed -i 's/VIRTUAL_ENV=.*/VIRTUAL_ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )\/.." \&\& pwd )"/' venv/bin/activate
rm -f venv/bin/activate.*

tar -cz venv
