FROM node:boron

RUN mkdir -p /root/.ssh

ADD ssh_key/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

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

RUN rm /root/.ssh/id_rsa

EXPOSE 8080

CMD [ "/bin/bash" ]
#CMD [ "npm", "run", "clean-all" ]
