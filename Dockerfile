FROM alpine:latest
LABEL maintainer "Peter Benjamin <petermbenjamin@gmail.com>"
WORKDIR /seclists/
RUN apk --no-cache add git \
    && git clone https://github.com/danielmiessler/seclists.git /seclists/
CMD ["sh"]

