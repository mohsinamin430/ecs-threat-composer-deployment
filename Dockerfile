ARG NODE_VERSION=20-alpine
ARG NGINX_VERSION=alpine3.22

#STAGE 1
FROM node:${NODE_VERSION} AS builder

#set workdir
WORKDIR /app

#install dependencies
COPY /app/package*.json /app/yarn.lock ./
RUN yarn install --frozen-lockfile

#cache dependencies
COPY /app . 

RUN yarn build


#STAGE 2
FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner

COPY /app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx --from=builder /app/build /usr/share/nginx/html

USER nginx

#expose port
EXPOSE 8080

ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]