const express = require('express');
const app = express();

const PORT = process.env.PORT || 4567; // non-standard default to induce mismatch
const APP_MESSAGE = process.env.APP_MESSAGE || 'Hello from the tiny app!';

app.get('/', (req, res) => res.status(200).send(APP_MESSAGE));
app.get('/health', (req, res) => res.status(200).send('OK')); // candidates may change to /status per guidelines

app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
