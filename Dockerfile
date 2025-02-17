FROM python:3.9-slim

WORKDIR /app

COPY myapp-source-code/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY myapp-source-code/myapp.py .

EXPOSE 6666

CMD [ "gunicorn", "--bind", "0.0.0.0:6666", "myapp:app"]
