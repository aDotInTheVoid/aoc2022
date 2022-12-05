FROM registry.gitlab.com/everythingfunctional/dockerfpm
WORKDIR /app
COPY . .
RUN fpm install --prefix=/app
CMD ["/app/bin/day03"]
