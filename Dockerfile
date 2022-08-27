# Building the site with Hugo

FROM klakegg/hugo AS build
COPY --from=0 /data /data
WORKDIR /data
RUN hugo -D --minify


# Expose the site using NGINX

FROM nginx:alpine
COPY --from=build /data/public /usr/share/nginx/html
