FROM --platform=linux/amd64 golang:1.22-alpine AS build
RUN apk add --no-cache gcc musl-dev
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN go mod tidy
ENV CGO_ENABLED=1
RUN go build -o .

FROM --platform=linux/amd64 alpine:latest
RUN mkdir /app
COPY ./static /app/static
COPY --from=build /app /app
WORKDIR /app
CMD [ "./wuzapi" ]