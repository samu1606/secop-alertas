FROM busybox
COPY landing/index.html /var/www/index.html
CMD ["httpd", "-f", "-v", "-p", "80", "-h", "/var/www"]
EXPOSE 80
