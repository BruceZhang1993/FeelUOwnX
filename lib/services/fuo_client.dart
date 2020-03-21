import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:FeelUOwnX/setting.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../helpers.dart';

class FuoClient {
  static const MAX_TIMEOUT = 10;
  static final FuoClient _instance = FuoClient._internal();
  static Socket _socket;
  static BuildContext _context;
  static List<String> messageQueue = [];

  FuoClient._internal();

  Future<FuoClient> connect() async {
    StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
    String ipAddress = AppSettings(prefs).daemonIp.getValue();
    if (_socket == null) {
      _socket = await Socket.connect(ipAddress, 23333);
      _socket.listen(handle);
      await _socket.flush();
      showSnackBar(_context, 'Connected to FeelUOwn daemon.');
    }
    return this;
  }

  handle(Uint8List event) {
    messageQueue.add(utf8.decode(event));
  }

  Future<String> send(List<String> command) async {
    if (_socket != null) {
      messageQueue.clear();
      _socket.add(utf8.encode(command.join(' ') + '\r\n'));
      // Wait for response
      int counter = 0;
      while (messageQueue.length == 0) {
        if (counter > MAX_TIMEOUT) {
          showSnackBar(_context, 'Daemon response timeout after $MAX_TIMEOUT seconds.');
          break;
        }
        await Future.delayed(Duration(seconds: 1));
        counter++;
      }
      return messageQueue.first;
    } else {
      showSnackBar(_context, 'Not connected to daemon.');
      return '';
    }
  }

  factory FuoClient(BuildContext context) {
    _context = context;
    return _instance;
  }

  Socket get socket {
    return _socket;
  }
}
