FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY landing/index.html /usr/share/nginx/html/index.html
EXPOSE 80
