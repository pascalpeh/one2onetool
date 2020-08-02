FROM alpine:latest
RUN apk add --no-cache nodejs npm
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN mkdir -p /app; chown -R appuser:appgroup /app
USER appuser
WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 3000
CMD ["node", "index.js"]