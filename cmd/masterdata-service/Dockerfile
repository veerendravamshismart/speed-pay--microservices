# Use the official Golang image as a build environment
FROM golang:1.19-alpine as build

# Set the working directory for the build stage
WORKDIR /app

# Copy go modules and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go binary
RUN go build -o /masterdata-service .

# Second stage to create the final image
FROM alpine:latest

# Set the working directory in the final image
WORKDIR /app

# Copy the built binary from the build stage
COPY --from=build /masterdata-service .

# Copy the .env file into the container
COPY .env /app/.env

ENV DATABASE_URL=postgres://postgres:yourpassword@postgres:5432/postgres?sslmode=disable
ENV REDIS_ADDR=redis:6379
ENV REDIS_PASS=yourpassword
ENV PORT=8081


# Expose the port where your service will run (ensure consistency with your .env file)
EXPOSE 8080

# Run the application
CMD ["./masterdata-service"]
