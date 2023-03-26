## Base ########################################################################
FROM golang:latest as base

# Create a non-root user
RUN adduser --disabled-password --gecos '' appuser
WORKDIR /go/src/app
COPY src/ .
RUN chown -R appuser:appuser /go/src/app && \
    chmod -R 755 /go/src/app && \
    go mod download && \
    apt-get update && apt-get -y upgrade && apt-get -y --no-install-recommends install ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*

USER appuser

## Development #################################################################
FROM base as development
WORKDIR /go/src/app
EXPOSE 8080
CMD ["go", "run", "main.go"]

## Production ##################################################################
FROM base as production
WORKDIR /go/src/app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/main .
RUN rm -rf /go/src/app/*
CMD ["/go/bin/main"]

## Deploy ######################################################################
FROM alpine:latest as deploy
WORKDIR /go/src/app
COPY --from=production /go/bin/main .
RUN apk --no-cache add ca-certificates
EXPOSE 8080
CMD ["/go/src/app/main"]
