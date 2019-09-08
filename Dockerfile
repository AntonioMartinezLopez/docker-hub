FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#relevanten (statischen) Daten liegen in /app/build

FROM nginx
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# kein start command notwendig, sobald container gestartet wird wird auch nginx hochgefahren

#EXPOSE 80 fuer elastic Beanstalk, damit dieser port gemapped wird
#fuer den eingehenden verkehr
