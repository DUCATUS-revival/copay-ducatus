FROM node:boron
#FROM beevelop/android-nodejs:latest
RUN apt-get update

# Install Java.
RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y -t jessie-backports openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean 
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update \
    && apt-get install -y --force-yes expect wget \
    libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.zip \
    https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    apt-get install unzip && \
    unzip android-sdk.zip && mkdir android-sdk-linux && mv tools /opt/android-sdk-linux/tools && \ 
    rm -f android-sdk.zip && \
    chown -R root.root android-sdk-linux

# Install Platform Tools
RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip -d /opt/android-sdk-linux/ platform-tools-latest-linux.zip

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
#RUN find / -iname tools && ls -la /opt/android-sdk-linux/tools
RUN cp -R /opt/android-sdk-linux/tools/ /opt/tools/
ENV PATH ${PATH}:/opt/tools
ENV USE_SDK_WRAPPER y
RUN apt-get install -y expect
RUN wget -O /opt/tools/android-accept-licenses.sh https://raw.githubusercontent.com/oren/docker-ionic/master/tools/android-accept-licenses.sh \ 
    && chmod 755 /opt/tools/android-accept-licenses.sh
# RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter build-tools-25.0.3,android-25"]
RUN echo y | android update sdk --all --no-ui --filter build-tools-25.0.3,android-25
# Cleaning
RUN apt-get clean
RUN find / -iname javac

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install -g grunt bower
RUN npm install

# Bundle app source
COPY . /usr/src/app

COPY networks.js node_modules/bitcore-lib/lib/networks.js
RUN npm run clean-all
RUN bower install --allow-root
RUN npm run apply:copay
COPY build.gradle.android /usr/src/app/platforms/android/build.gradle
RUN wget -O gradle.zip https://downloads.gradle.org/distributions/gradle-4.2-bin.zip && \
	unzip gradle.zip -d / && \ 
	ln -sf /gradle-4.2/bin/gradle /usr/bin/gradle && \ 
	ls -la
EXPOSE 8080

CMD [ "/bin/bash" ]
#CMD [ "npm", "run", "clean-all" ]
