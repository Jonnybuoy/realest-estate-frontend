FROM node:14 as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN ls -al /app
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
