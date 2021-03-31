FROM python:3.9.2-slim-buster

WORKDIR /opt/tests

COPY ./test.py /opt/tests/

RUN pip3 install --upgrade pip
RUN pip3 install selenium

CMD  ["python", "test.py"]