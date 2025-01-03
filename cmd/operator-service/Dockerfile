# Use the official Golang image as a build environment
FROM golang:1.19-alpine as build

# Set the working directory
WORKDIR /app

# Copy go modules and install dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go binary
RUN go build -o /operator-service .

# Second stage to create the final image
FROM alpine:latest

# Set the working directory in the final image
WORKDIR /root/

# Copy the built binary from the build stage
COPY --from=build /operator-service .

# Copy the .env file into the container
COPY .env /root/.env

# Set up environment variables for connecting to Redis and PostgreSQL.
# These need to reflect your actual host and port configuration.
# Since the Redis and Postgres services are likely already running on the host machine
# or in Docker, configure their addresses and ports appropriately.

# If running on Docker, ensure the services (redis and postgres) are reachable by the containers' network.
ENV DATABASE_URL=postgres://postgres:yourpassword@host.docker.internal:5432/postgres?sslmode=disable
ENV REDIS_ADDR=host.docker.internal:6379
ENV REDIS_PASS=yourpassword
ENV PORT=8081

# Expose the port where your service will run (mapped to host's port 8080)
EXPOSE 8081

# Run the application (make sure the binary has execution rights)
CMD ["./operator-service"]
