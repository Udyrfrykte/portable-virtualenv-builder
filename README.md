### Portable virtualenv builder

## Usage

This tool uses a Docker image that will package a portable virtualenv that should be compatible with the corresponding OS.

For now, available OSes are :
 - Centos
  - 6

Build the packaging image :
```
docker image build -t packaging_image:latest -f <selected OS>.Dockerfile .
```

Once this image is built, you can use it to generate portable virtualenv TARs. It will wirk as a commandline tool that expect a PIP-style requirement input on STDIN and outputs a gzipped tar archive of the corresponding virtualenv.

Example :
```
echo $'requests==2.18.1\nchardet==3.0.4' | docker run --rm -i packaging_image > venv.tgz
```

Optionally you can specify build dependencies that may be needed to install the PIP libraries using the BUILD_PACKAGES environment variable.

Example :
```
cat requirements.txt | docker run --rm -i -e BUILD_PACKAGES='gcc openssl-devel libffi-devel' packaging_image > venv.tgz
```
