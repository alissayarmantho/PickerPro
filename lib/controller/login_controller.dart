import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;
  var isLoading = false.obs;

  void login({required String email, required String password}) async {
    isLogin.value = true;
  }

  void logout() {
    isLogin.value = false;
  }
}
