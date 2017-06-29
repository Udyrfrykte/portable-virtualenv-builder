# Portable virtualenv builder

This tool uses a Docker image that will package a portable virtualenv. The generated package should be compatible with the base OS of the image.

For now, available OSes are :
 - Centos 6

## Usage

Build the packaging image :
```
docker image build -t packaging_image:latest -f <selected OS>.Dockerfile .
```

Once this image is built, you can use it to generate portable virtualenv TARs. It will work as a command line tool that expects a PIP-style requirement input on STDIN and outputs a gzipped tar archive containing the corresponding virtualenv on STDOUT.

Example :
```
echo $'requests==2.18.1\nchardet==3.0.4' | docker run --rm -i packaging_image > venv.tgz
```

Additionally, you can specify build dependencies that may be needed to install the PIP libraries using the BUILD_PACKAGES environment variable.

Example :
```
cat requirements.txt | docker run --rm -i -e BUILD_PACKAGES='gcc openssl-devel libffi-devel' packaging_image > venv.tgz
```
