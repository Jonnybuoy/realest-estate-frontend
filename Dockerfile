# Build the app
FROM node:14 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --production --legacy-peer-deps
COPY . .
RUN npm run build

# Serve the app with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
