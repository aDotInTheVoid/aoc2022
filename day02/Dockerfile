# podman build . -t day02

FROM docker.io/clojure:temurin-11-lein-alpine

WORKDIR /app

COPY project.clj .

RUN lein deps

COPY . .

ENTRYPOINT ["lein", "run"]