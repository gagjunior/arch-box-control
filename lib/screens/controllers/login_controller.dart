import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var selectedLang = Locale('pt', 'BR').obs;

}