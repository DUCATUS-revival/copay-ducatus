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

# Bundle app source
COPY . /src/app
#RUN ionic cordova platform rm android && \
#  rm -rf www/ platforms/ plugins/ && \
#  ionic cordova platform add android

RUN bower install --allow-root
RUN npm run apply:copay
RUN npm run build:www-release

# Web Wallet
#FROM nginx:alpine as web-wallet
#COPY --from=builder /src/app/www /usr/share/nginx/html
