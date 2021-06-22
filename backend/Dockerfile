FROM node:latest

WORKDIR /usr/src/app

COPY ./ /usr/src/app

RUN npm install
#RUN npm ci --only=production


#RUN npm run tsc

RUN npm run build


EXPOSE 7000
EXPOSE 4001
CMD [ "node", "dist/index.js" ]