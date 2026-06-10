#STAGE 1
FROM node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293 AS builder

#set workdir
WORKDIR /app

#install dependencies
COPY /app/package*.json /app/yarn.lock ./
RUN yarn install --frozen-lockfile

#cache dependencies
COPY /app . 

RUN yarn build


#STAGE 2
FROM nginxinc/nginx-unprivileged:alpine3.22 AS runner

COPY /app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx --from=builder /app/build /usr/share/nginx/html

USER nginx

#expose port
EXPOSE 8080

ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]