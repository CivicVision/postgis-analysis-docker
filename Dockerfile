FROM kartoza/postgis

RUN apt-get update
RUN apt-get install -y python-dev python-pip python-setuptools build-essential python-psycopg2

RUN pip install csvkit
