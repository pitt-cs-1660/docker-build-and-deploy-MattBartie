# Stage 1: Build the Go binary
FROM golang:1.23 AS builder
WORKDIR /app
COPY go.mod main.go ./
COPY templates/ ./templates/
RUN CGO_ENABLED=0 go build -o band-generator .

# Stage 2: Final minimal image
FROM scratch
COPY --from=builder /app/band-generator /band-generator
COPY --from=builder /app/templates /templates
EXPOSE 8080
ENTRYPOINT ["/band-generator"]
