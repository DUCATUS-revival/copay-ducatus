FROM node:boron

RUN mkdir -p /root/.ssh

ADD ssh_key/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
EXPOSE 8080

CMD [ "/bin/bash" ]
#CMD [ "npm", "run", "clean-all" ]
