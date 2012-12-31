#!/bin/sh

set -e -x
apt-get update -yqq || true
apt-get upgrade -yqq || true
apt-get install -q python$VER
curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python2.7-cython_0.17.1_i386.deb
curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-greenlet_0.4.0_i386.deb
curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-psycopg2_2.4.5_i386.deb
curl -sSLO --retry 5 --fail https://github.com/downloads/denik/packages/python$VER-pysendfile_2.0.0_i386.deb
curl -sSLO --retry 5 --fail http://pypi.python.org/packages/source/w/web.py/web.py-0.37.tar.gz #md5=93375e3f03e74d6bf5c5096a4962a8db
dpkg -i python2.7-cython_0.17.1_i386.deb
dpkg -i python$VER-greenlet_0.4.0_i386.deb
dpkg -i python$VER-psycopg2_2.4.5_i386.deb
dpkg -i python$VER-pysendfile_2.0.0_i386.deb
tar -xf web.py-0.37.tar.gz && cd web.py-0.37 && $PYTHON setup.py -q install && cd -
if [ "x$VER" = "x2.7" ]; then pip install --use-mirrors -q pep8; fi
cython --version
$PYTHON -c 'import greenlet; print greenlet, greenlet.__version__; import psycopg2; print psycopg2, psycopg2.__version__; import web; print web, web.__version__'

pip install -r requirements.txt --upgrade
