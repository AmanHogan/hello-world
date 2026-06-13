# Tiny static site served by nginx. This is the thing Jenkins builds into an image.
FROM nginx:1.27-alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
