import 'package:dio/dio.dart';
import 'package:last_prvoder/models/user.dart';

class Net_Dio {
  static final URL_get =
      "https://6265b7fedbee37aff9a83f80.mockapi.io/api/users/";
  static final URL_post =
      "https://6265b7fedbee37aff9a83f80.mockapi.io/api/users/";
  static final URL_del =
      "https://6265b7fedbee37aff9a83f80.mockapi.io/api/users/"; // id
  static final URL_put =
      "https://6265b7fedbee37aff9a83f80.mockapi.io/api/users/"; // id

  static Dio dio = Dio();

  static Future<String> GET({dynamic id = ''}) async {
    Response<String> res = await dio.get(URL_get + id.toString());
    if (res.statusCode == 200) return res.data!;
    return "";
  }

  static Future<String> Update(User u) async {
    Response<String> res = await dio.put(URL_put + u.id, data: u.ToJson());
    if (res.statusCode == 200) return res.data!;
    return "";
  }

  static Future<String> Delete(User user) async {
    Response<String> res = await dio.delete(URL_del + user.id);
    if (res.statusCode == 200) return res.data!;
    return "";
  }

  static Future<String> Create(User user) async {
    Response<String> res = await dio.post(URL_post, data: user.ToJson());
    if (res.statusCode == 200 || res.statusCode == 201) return res.data!;
    return "";
  }
}
