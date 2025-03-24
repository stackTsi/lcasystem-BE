FROM node:18.17.0-alpine AS build

# Install OpenSSL 1.1 compatibility package (needed due to "https://github.com/prisma/prisma/issues/16553")
RUN apk add --no-cache openssl1.1-compat 
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npx prisma generate --schema=prisma/schema.prisma
EXPOSE 4000
CMD ["npm", "start"]