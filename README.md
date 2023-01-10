# Usage

```
docker build -t bufr-glider .
docker run -it -v ${pwd}:/local
cd /local
Rscript extract-test-data.R
python main.py
/opt/eccodes/bin/bufr_dump ./test-data/output/glider-test.bufr
```