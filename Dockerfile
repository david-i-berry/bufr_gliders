###############################################################################
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
###############################################################################

FROM ubuntu:focal

ARG BUILD_PACKAGES="build-essential curl cmake gfortran" \
    ECCODES_VER=2.27.1

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Etc/UTC" \
    ECCODES_DIR=/opt/eccodes \
    PATH="$PATH;/opt/eccodes/bin"

WORKDIR /tmp/eccodes

RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until \
    && apt-get update -y \
    && apt-get install -y ${BUILD_PACKAGES} python3 python3-pip libffi-dev python3-dev libudunits2-0 \
    && apt-get install -y r-base-dev libnetcdf-dev libssl-dev \
    && curl https://cran.r-project.org/src/contrib/ncdf4_1.21.tar.gz --output ncdf4_1.21.tar.gz \
    && curl https://cran.r-project.org/src/contrib/jsonlite_1.8.4.tar.gz --output jsonlite_1.8.4.tar.gz \
    && curl https://cran.r-project.org/src/contrib/httr_1.4.4.tar.gz --output httr_1.4.4.tar.gz \
    && R CMD INSTALL ncdf4_1.21.tar.gz \
    && R CMD INSTALL jsonlite_1.8.4.tar.gz \
    && R CMD INSTALL httr_1.4.4.tar.gz \
    && pip install --upgrade pip \
    && curl https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${ECCODES_VER}-Source.tar.gz --output eccodes-${ECCODES_VER}-Source.tar.gz \
    && tar xzf eccodes-${ECCODES_VER}-Source.tar.gz \
    && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=${ECCODES_DIR} -DENABLE_AEC=OFF ../eccodes-${ECCODES_VER}-Source && make && ctest && make install \
    && pip install eccodes \
    && cd / && rm -rf /tmp/eccodes \
    && apt-get remove --purge -y ${BUILD_PACKAGES} \
    && apt autoremove -y  \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

ADD ./test-data/tables/39 /opt/eccodes/share/eccodes/definitions/bufr/tables/0/wmo/39

WORKDIR /
