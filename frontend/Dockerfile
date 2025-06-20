# Build stage
FROM node:22-alpine AS build
WORKDIR /app
COPY . .
RUN npm install --frozen-lockfile || pnpm install --frozen-lockfile || yarn install --frozen-lockfile
RUN npm run build || pnpm run build || yarn build

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
