FROM node:alpine as build

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --prod

COPY . . 

RUN yarn build

# production environment
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

