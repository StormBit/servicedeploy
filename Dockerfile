# Add DNSSync Dependency
FROM golang:1.11-alpine as dnssync-builder
RUN apk add git
RUN git clone https://github.com/stormbit/dnssync /build/
WORKDIR /build
ENV GO111MODULE on
ENV CGO_ENABLED 0
RUN go build -o dnssync cmd/dnssync/main.go

# Add AWS CLI Dependency
FROM python:alpine
COPY --from=dnssync-builder /build/dnssync /usr/bin/
RUN pip install awscli
