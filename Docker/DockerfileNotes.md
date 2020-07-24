# Dockerfile Notes

#### In Dockerfile its better to separate the requirements file such as Package.json, requirements.txt from the rest of the copy process to speed up the image building process.
```YAML
FROM python:alpine3.10
WORKDIR /app
COPY requirements.txt /app/requirements
RUN pip install -r requirements.txt
EXPOSE 5000
COPY ./app
CMD python ./launch.py
```