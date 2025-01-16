import 'package:chat_bot/delivery.dart';
import 'package:chat_bot/public.dart';
import 'package:get/get.dart';

class ChatItem {
  String text;
  DeliveryStatus deliveryStatus = DeliveryStatus.none;
  final DateTime dateTime;
  bool isInput = false;

  ChatItem(this.text, this.deliveryStatus, this.dateTime, this.isInput);

  getDateTimeString() {
    final publicValues = Get.find<PublicValues>();
    return publicValues.formatter.format(dateTime);
  }
}
