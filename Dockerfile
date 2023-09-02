# Stage 1: Build an Angular Docker Image
FROM node as build
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
ARG configuration=production
RUN npx nx run ci-cd:build

# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/ci-cd /usr/share/nginx/html
EXPOSE 80