const express = require("express");
var http = require("http");
const app = express();
const port = 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");

var io = require("socket.io")(server);

app.use(express.json())

const DB = "mongodb+srv://aryan:Noddy%40123@skribbl.dynwkvf.mongodb.net/?retryWrites=true&w=majority&appName=Skribbl";

mongoose.connect(DB).then(() => {console.log("Connection succesfull")}).catch((e) => {console.log("Error connecting: " + e)});

server.listen(port, "0.0.0.0", () => {console.log("server started and running on port " + port)})