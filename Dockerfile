# Cloning the theme

FROM alpine/git AS clone
COPY . /src
WORKDIR /src
RUN rm -rf themes/*
RUN git clone https://github.com/panr/hugo-theme-terminal.git themes/terminal

# Building the site with Hugo

FROM klakegg/hugo:0.101.0 AS build
COPY --from=clone /src
WORKDIR /src
RUN hugo -D --minify

# Expose the site using NGINX

FROM nginx:alpine
COPY --from=build /src/public /var/www/html
