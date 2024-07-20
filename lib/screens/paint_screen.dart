import "package:flutter/material.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  const PaintScreen({required this.data, required this.screenFrom});
  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late IO.Socket _socket;
  String dataOfRoom = "";

  @override
  void initState() {
    super.initState();
    connect();
    print(widget.data);
  }

  void connect() {
    _socket = IO.io("http://172.25.239.82:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    if (widget.screenFrom == 'createRoom') {
      _socket.emit('create-game', widget.data);
    }

    _socket.on('updateRoom', (roomData) {
      setState(() {
        dataOfRoom = roomData;
      });
      if (roomData['isJoin'] != true) {
        // timer here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
