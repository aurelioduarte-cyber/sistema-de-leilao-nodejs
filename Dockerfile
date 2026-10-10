FROM node:18-alpine

RUN apk add --no-cache openssl

WORKDIR /usr/app

COPY package*.json ./

RUN npm install

COPY . .

# Se o prisma estiver em prisma/schema.prisma ou backend/prisma/schema.prisma,
# o Prisma detecta automaticamente executando npx prisma generate sem caminhos fixos
RUN npx prisma generate || npx prisma generate --schema=backend/prisma/schema.prisma

EXPOSE 3000

CMD ["node", "backend/src/server.js"]