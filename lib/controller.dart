import 'package:chat_bot/chatItem.dart';
import 'package:chat_bot/delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class Controller extends GetxController {
  var activeStep = 0.obs;

  RxList<ChatItem> chats = <ChatItem>[].obs;

  final chatTextController = TextEditingController();

  IO.Socket socket = IO.io(
      'http://127.0.0.1:3000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Add websocket transport type
          //.disableAutoConnect()
          .build());

  var connectionStatus = 'Connecting'.obs;
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();

    socket.connect();
    socket.onConnect((_) {
      connectionStatus.value = "Connected";
      isConnected.value = true;
    });

    socket.onDisconnect((_) {
      connectionStatus.value = "Connecting";
      isConnected.value = false;
    });
  }

  @override
  void dispose() {
    chatTextController.dispose();
    super.dispose();
  }

  sendMessage() async {
    var msg = chatTextController.text.trim();
    if (msg == '') return;
    ChatItem newChat =
        ChatItem(msg, DeliveryStatus.pending, DateTime.now(), false);
    chats.add(newChat);

    chatTextController.clear();

    socket.emitWithAck('message', msg, ack: (data) {
      chats.firstWhereOrNull((chat) => chat == newChat)?.deliveryStatus =
          DeliveryStatus.sent;
      var response = data;
      chats.add(
          ChatItem('$response', DeliveryStatus.none, DateTime.now(), true));
    });


  }

  IconData? getDeliveryIcon(ChatItem chatItem) {
    switch (chatItem.deliveryStatus) {
      case DeliveryStatus.none:
        return null;
      case DeliveryStatus.pending:
        return Icons.watch_later_outlined;
      case DeliveryStatus.sent:
        return Icons.check_circle_outline;
    }
  }
}
