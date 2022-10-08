FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /go-github-action-test

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /go-github-action-test /go-github-action-test

USER nonroot:nonroot

ENTRYPOINT [ "/go-github-action-test" ]