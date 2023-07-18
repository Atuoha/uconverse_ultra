import 'package:get/get.dart';
import '../../../common/entities/msgcontent.dart';

class ChatState {
  final RxList<Msgcontent> msgContent = <Msgcontent>[].obs;

  var toName = "".obs;
  var toAvatar = "".obs;
  var toToken = "".obs;
  var toOnline = "".obs;
}
