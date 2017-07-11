FROM node:boron
#FROM beevelop/android-nodejs:latest


# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install -g grunt bower
RUN npm install

# Bundle app source
COPY . /usr/src/app

RUN npm run clean-all
RUN bower install --allow-root
RUN npm run apply:copay

EXPOSE 8080

CMD [ "/bin/bash" ]
#CMD [ "npm", "run", "clean-all" ]
