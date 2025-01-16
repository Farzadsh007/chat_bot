import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class PublicValues extends GetxController {
  final _formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateFormat get formatter => _formatter;
}
