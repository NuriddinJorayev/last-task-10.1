import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:last_prvoder/models/user.dart';
import 'package:last_prvoder/services/dio_net.dart';

class Home_control extends ChangeNotifier {
  List<User> base_list = List<User>.empty();
  bool isLoading = false;
  bool isDio = false;

  Home_control() {
    initialize();
  }

  List<User> list_item_delete(int index, User u) {
    Net_Dio.Delete(u).then((value) {
      print(value);
    });
    base_list.removeAt(index);
    base_list = base_list;
    notifyListeners();
    return base_list;
  }

  setstate() {
    notifyListeners();
  }

  initialize() async {
    print("init");
    isLoading = true;
    notifyListeners();
    var json = await Net_Dio.GET();
    get(json);
    isLoading = false;
    notifyListeners();
  }

  List<User> get(String json) {
    base_list = List<User>.from(jsonDecode(json).map((e) => User.fromjson(e)));
    print(base_list.length);
    notifyListeners();
    return base_list;
  }
}
