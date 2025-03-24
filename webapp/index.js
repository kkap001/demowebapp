// index.js
const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => {
    const message = process.env.WEBTEXT || 'Hello World!';
    res.send(message);
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
