FROM python:3.8
ENV TZ=Europe/Kyiv
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

###################################
#	ENV DB_HOST=""
#	ENV DB_USER=""
#	ENV DB_PASSWORD=""
#	ENV DB_NAME=""
#	ENV DB_PORT=""
#	ENV HISTORY_VALUE=""
#	ENV TRENDS_VALUE=""
###################################

RUN pip install mysql-connector-python
COPY root /
CMD ["python", "template_redactor.py"]

