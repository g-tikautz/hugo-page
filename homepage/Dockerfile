FROM alpine:latest

# Install Hugo
ENV HUGO_VERSION 0.82.0
RUN apk add --no-cache curl && \
    curl -L -o /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /tmp && \
    mv /tmp/hugo /usr/local/bin && \
    rm -rf /tmp/*

# Create the working directory
RUN mkdir /site
WORKDIR /site

# Copy the website source code into the container
COPY . /site

# Build the website using Hugo
RUN hugo --minify

# Use a lightweight web server to serve the website
FROM nginx:alpine
COPY --from=0 /site/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
