const express = require('express');
const redis = require('redis');

const app = express();
const client = redis.createClient();

// set initial value
client.set('count', 0);

app.get('/', (req, res) => {
  client.get('count', (err, count) => {
    res.send('Counter equals: ' + count);

    client.set('count', parseInt(count, 10) + 1);
  });
});

app.listen(3000, () => console.log('Listening on port 3000...'));
