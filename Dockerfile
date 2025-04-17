# Step 1: Build the React app using Vite
FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve the build with Nginx
FROM nginx:alpine

# Copy build output from Vite (it's in /app/dist)
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
