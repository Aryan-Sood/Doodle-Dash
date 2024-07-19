import "package:flutter/material.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    _socket = IO.io("http://172.25.239.82:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
    // print("first");

    _socket.onConnect((data) {
      print(data);
    });
    // _socket.onError((error) {
    //   print(error);
    // });

    // _socket.onConnectError((error) {
    //   print(error);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
