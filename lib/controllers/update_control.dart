import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:last_prvoder/models/user.dart';
import 'package:last_prvoder/services/dio_net.dart';

class Update_Control extends ChangeNotifier {
  bool isloading = false;

  Future<String> update_user(String title, String body, String id) async {
    isloading = true;
    notifyListeners();
    var a = await Net_Dio.Update(User(id: id, title: title, body: body));
    isloading = false;
    notifyListeners();
    return a;
  }
}
