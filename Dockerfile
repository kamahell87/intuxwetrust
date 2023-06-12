# Cloning the theme

FROM alpine/git AS clone
COPY . /data
WORKDIR /data
RUN rm -rf themes/*
RUN git clone https://github.com/kamahell87/hugo-theme-terminal.git themes/terminal

# Building the site with Hugo

FROM klakegg/hugo:0.107.0-ext AS build
COPY --from=clone /data /data
WORKDIR /data
RUN hugo -D

# Expose the site using NGINX

FROM nginx:alpine
COPY --from=build /data/public /usr/share/nginx/html
