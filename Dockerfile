#STAGE 1
FROM node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293 AS builder

#set workdir
WORKDIR /app

#install dependencies
COPY package*.json yarn.lock ./
RUN yarn install --frozen-lockfile

#cache dependencies
COPY . .

RUN yarn build


#STAGE 2
FROM nginx:alpine3.22 AS runner

COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

#RUN addgroup -S app && adduser -S app -G app 
#USER app

#expose port
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]