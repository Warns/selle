# Dockerfile Notes

In Dockerfile its better to separate the requirements file such as Package.json, requirements.txt from the rest of the copy process to speed up the image building process.
```sh
FROM python:alpine3.10
WORKDIR /app
COPY requirements.txt /app/requirements #This step separates the requirements since it doesn't change often
RUN pip install -r requirements.txt
EXPOSE 5000
COPY ./app
CMD python ./launch.py
```

Difference between CMD and ENTRYPOINT in Dockerfile. When you use CMD in Dockerfile it can be overwritten by a command line argument. Meaning whatever you pass in the docker run -d -p etc. command line such as below will overwrite the CMD linen in Dockerfile. In the below case ping google.com overwrites the CMD line. But if you use ENTRYPOINT instead of CMD then it will not be overwriten by such a command line argument.
```sh
docker run -d -p 5000:5000 warns/hello-world-nodejs:0.0.2.RELEASE ping google.com #the ping argument will overwrite the CMD node index.js found in the Dockerfile
ENTRYPOINT ["sh", "-c", "java -jar /project.jar"] #This will not be overwriten by ping google.com

#There is one way to overwrite even ENTRYPOINT which is by including --entrypoint [argument] in the command line.
```

