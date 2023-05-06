FROM python:3.11-alpine 

RUN pip install --no-cache-dir pipenv

COPY ./rest /app

WORKDIR /app

RUN pipenv install --system --deploy && pipenv --clear

EXPOSE 8080

ENTRYPOINT ["python"]

CMD ["./rest.py"]
