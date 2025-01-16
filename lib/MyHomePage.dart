import 'package:chat_bot/chatItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/icon.png'),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        controller.connectionStatus.value,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (!controller.isConnected.value)
                        LoadingAnimationWidget.progressiveDots(
                          color: Colors.white,
                          size: 14,
                        ),
                    ],
                  )),
            ],
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  return _buildChatMessage(controller.chats[index]);
                },
              ),
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                // color:  Colors.grey,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: const Color(0xFF4D4D4D), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.chatTextController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,

                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () => controller.sendMessage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(ChatItem message) {
    return Align(
      alignment:
          !message.isInput ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: !message.isInput
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: message.isInput
                  ? const Color(0xFF4D4D4D)
                  : const Color(0xFF0A0808),
            ),
            child: Text(
              message.text,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.getDateTimeString(),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                controller.getDeliveryIcon(message),
                size: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}
