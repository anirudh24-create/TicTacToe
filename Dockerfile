FROM python:3.9-slim-buster
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY tictactoe.py .
COPY templates/ /app/templates/
COPY static/ /app/static/
EXPOSE 8080
CMD ["python", "tictactoe.py"]