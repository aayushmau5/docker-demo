# Use ubuntu:latest as base image
FROM ubuntu:latest

COPY ./cmd.txt .

CMD [ "cat", "/cmd.txt" ]