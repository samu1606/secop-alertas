FROM python:3-alpine
COPY landing/index.html /app/index.html
WORKDIR /app
EXPOSE 80
CMD ["python", "-m", "http.server", "80"]
