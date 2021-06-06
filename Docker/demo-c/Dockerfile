FROM node:16.2-alpine3.11

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY package.json .
RUN npm install

COPY . .

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

CMD ["npm", "start"]
