# FROM node:18-alpine

# WORKDIR /react-app

# COPY public/ ./public
# COPY src/ ./src
# COPY package.json ./

# RUN npm install

# CMD ["npm", "start"]

# Stage 1: Build the application
FROM node:18-alpine AS builder

WORKDIR /react-app

COPY public/ ./public
COPY src/ ./src
COPY package.json ./
COPY package-lock.json ./

RUN npm install

RUN npm run build

# Stage 2: Serve the application with a lightweight web server
FROM nginx:alpine

COPY --from=builder /react-app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
