FROM node:8 as builder

RUN mkdir -p /root/.ssh

ADD ssh_key/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Create app directory
WORKDIR /src/app

# Install app dependencies
COPY package.json /src/app/
COPY package-lock.json /src/app/
COPY bower.json /src/app/
RUN npm install -g grunt bower ionic
RUN npm install
RUN apt update; apt install -y vim; cp /usr/share/vim/vim74/vimrc_example.vim ~/.vimrc

# Bundle app source
COPY . /src/app

RUN bower install --allow-root
RUN npm run apply:copay
RUN npm run build:www-release

# Web Wallet
FROM nginx:alpine as web-wallet
COPY --from=builder /src/app/www /usr/share/nginx/html
