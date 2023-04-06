# syntax=docker/dockerfile:1
FROM golang:1.20-buster AS deploy-builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -trimpath -ldflags "-w -s" -o /app/main

FROM gcr.io/distroless/base-debian11 AS deploy
WORKDIR /app
COPY --from=deploy-builder /app/main /app/main
USER nonroot:nonroot
CMD ["/app/main"]

FROM golang:1.20-buster AS dev
WORKDIR /app
RUN go install github.com/cosmtrek/air@latest && \
    go install github.com/go-delve/delve/cmd/dlv@latest
CMD ["air"]
