# Building the site with Hugo

FROM klakegg/hugo:0.101.0 AS build
COPY . /src
WORKDIR /src
RUN hugo -D


# Expose the site using NGINX

FROM nginx:alpine
COPY --from=build /src/public /var/www/html
