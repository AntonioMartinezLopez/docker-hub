FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#relevanten (statischen) Daten liegen in /app/build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# kein start command notwendig, sobald container gestartet wird wird auch nginx hochgefahren


