FROM mhart/alpine-node

ENV NODE_ENV=production
EXPOSE 53/udp

ADD package.json /tmp/package.json

RUN cd /tmp && npm install
COPY *.js /usr/src/

RUN ln -sf /tmp/node_modules /usr/src/node_modules
RUN ln -sf /tmp/package.json /usr/src/package.json

# Run
CMD [ "node", "/usr/src/index.js" ]
