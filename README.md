# Usage

```
docker build -t bufr-glider .
docker run -it -v ${pwd}:/local bufr-glider
```
Note due to an error in the Dockerfile (that wasn't resolvable in the time available) R and httr need to be installed 
after the build of the image.

```
apt-get update -y
apt-get install -y r-base-dev
R --no-save <<!
install.packages('httr')
!
cd /local
Rscript extract-test-data.R
python main.py
/opt/eccodes/bin/bufr_dump ./test-data/output/glider-test.bufr
```