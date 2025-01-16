import 'package:chat_bot/public.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
    Get.lazyPut<PublicValues>(() => PublicValues());
  }
}
