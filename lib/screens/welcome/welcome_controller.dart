import 'package:arch_box_control/services/user_service.dart';
import 'package:get/get.dart';

class WelcomeCrontroller extends GetxController {

  Map<String, dynamic> loggedUser = UserService.getLoggedUserInfo();
  
}