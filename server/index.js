const express = require("express");
var http = require("http");
const app = express();
const port = 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");
const Room = require("./models/room");
const getWord = require("./API/getWord");

var io = require("socket.io")(server);

app.use(express.json())

const DB = "mongodb+srv://aryan:Noddy%40123@skribbl.dynwkvf.mongodb.net/?retryWrites=true&w=majority&appName=Skribbl";

mongoose.connect(DB).then(() => {console.log("Connection succesfull")}).catch((e) => {console.log("Error connecting: " + e)});

io.on('connection', (socket) => {
    console.log('connected');
    socket.on('create-game', async({nickname, name, occupancy, maxRounds}) => {
        try{
            const existingRoom = await Room.findOne({name});
            if (existingRoom){
                socket.emit('notCorrectGame', 'Room with that name already exists');
                return
            }
            let room = new Room();
            const word = getWord();
            room.word = word;
            room.name = name;
            room.occupancy = occupancy;
            room.maxRounds = maxRounds;

            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader: true,
            }

            room.players.push(player);
            room = await room.save();
            socket.join(room);
            io.to(name).emit('updateRoom', room);
        }
        catch(err){
            console.log(error);
        }
    })
})

server.listen(port, "0.0.0.0", () => {console.log("server started and running on port " + port)})