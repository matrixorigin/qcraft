// To test: curl -X POST http://localhost:3000/send-text -H "Content-Type: application/json" -d '{"text":"Your English text here"}'
const express = require('express');
const axios = require('axios');

const app = express();

const port = 3000;

//Parses JSON bodies in incoming requests
app.use(express.json());

//POST endpoint at path "/send-text"
app.post('/send-text', async (req, res) => {
    //Extract text from the request body
    const { text } = req.body;
    if (!text) {
        return res.status(400).send("PLEASE INCLUDE TEXT");
    }
    try {
        const response = await axios.post('http://localhost:8002/query-data', { text });
        res.json(response.data);
    }
    catch (error) {
        console.log("ERROR: ", error);
        res.status(500).send("An error occured: ", error);
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}!`);
});