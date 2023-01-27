FROM node:16-alpine as build-front
COPY . /app
WORKDIR /app
RUN yarn install \
    && yarn dev

FROM webdevops/php-nginx:8.1-alpine as base
ENV WEB_DOCUMENT_ROOT '/var/www/html/public'

FROM base as prod
# Add application
WORKDIR /var/www/html
COPY . /var/www/html/

RUN composer install

COPY --from=build-front /app/public/build ./public/build

# Expose the port nginx is reachable on
EXPOSE 80