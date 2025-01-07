# # Stage 1: Build the masterdata-service
# FROM golang:1.19-alpine as masterdata-build

# # Set the working directory for masterdata-service build
# WORKDIR /app/cmd/masterdata-service

# # Copy go modules and install dependencies
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy the source code for masterdata-service into the container
# COPY . .

# # Build the masterdata-service binary
# RUN go build -o /masterdata-service

# # Stage 2: Build the operator-service
# FROM golang:1.19-alpine as operator-build

# # Set the working directory for operator-service build
# WORKDIR /app/cmd/operator-service

# # Copy go modules and install dependencies for operator-service
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy the source code for operator-service into the container
# COPY . .

# # Build the operator-service binary
# RUN go build -o /operator-service

# # Stage 3: Create a minimal image for masterdata-service-1
# FROM alpine:latest as masterdata-final

# # Set the working directory for the final masterdata image
# WORKDIR /root/

# # Copy the built masterdata-service binary from the build stage
# COPY --from=masterdata-build /masterdata-service .

# # Copy the .env file into the container
# COPY .env /root/.env

# # Set up environment variables for connecting to Redis and PostgreSQL for masterdata-service-1
# ENV DATABASE_URL=postgres://postgres:yourpassword@host.docker.internal:5432/postgres?sslmode=disable
# ENV REDIS_ADDR=host.docker.internal:6379
# ENV REDIS_PASS=yourpassword
# ENV PORT=8081

# # Expose the port where your service will run (mapped to host's port 8081)
# EXPOSE 8081

# # Run the masterdata-service-1
# CMD ["./masterdata-service"]

# # Stage 4: Create a minimal image for operator-service-1
# FROM alpine:latest as operator-final

# # Set the working directory for the final operator image
# WORKDIR /root/

# # Copy the built operator-service binary from the build stage
# COPY --from=operator-build /operator-service .

# # Copy the .env file into the container
# COPY .env /root/.env

# # Set up environment variables for connecting to Redis and PostgreSQL for operator-service-1
# ENV DATABASE_URL=postgres://postgres:yourpassword@host.docker.internal:5432/postgres?sslmode=disable
# ENV REDIS_ADDR=host.docker.internal:6379
# ENV REDIS_PASS=yourpassword
# ENV PORT=8081

# # Expose the port where your service will run (mapped to host's port 8081)
# EXPOSE 8081

# # Run the operator-service-1
# CMD ["./operator-service"]

# Stage 1: Build the masterdata-service

FROM golang:1.19-alpine as build-masterdata

WORKDIR /app/cmd/masterdata-service

COPY go.mod go.sum ./
RUN go mod download

COPY . .
COPY cmd/masterdata-service /app/cmd/masterdata-service


RUN go build -o app/cmd/masterdata-service

FROM golang:1.19-alpine as build-operator

WORKDIR /app/cmd/operator-service

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o app/cmd/operator-service

FROM alpine:latest

WORKDIR /root/

COPY --from=build-masterdata /masterdata-service .
COPY --from=build-operator /operator-service .

COPY .env /root/.env

ENV DATABASE_URL=postgres://postgres:yourpassword@host.docker.internal:5432/postgres?sslmode=disable
ENV REDIS_ADDR=host.docker.internal:6379
ENV REDIS_PASS=yourpassword
ENV MASTERDATA_PORT=8081
ENV OPERATOR_PORT=8082

EXPOSE 8081
EXPOSE 8082

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh

CMD ["/root/start.sh"]
