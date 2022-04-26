import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:last_prvoder/models/user.dart';
import 'package:last_prvoder/services/dio_net.dart';

class Create_Control extends ChangeNotifier {
  bool isloading = false;

  Future<String> Create_user(User u) async {
    isloading = true;
    notifyListeners();
    var res = await Net_Dio.Create(u);
    isloading = false;
    notifyListeners();
    return res;
  }
}
