import 'package:flutter/material.dart';
import 'package:last_prvoder/controllers/update_control.dart';
import 'package:last_prvoder/models/user.dart';
import 'package:last_prvoder/widgets/textfield_build.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  static final String Route_name = "/Update_page";
  final User? user;
  const UpdatePage({Key? key, this.user}) : super(key: key);
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var control1 = TextEditingController();
  var control2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      control1.text = widget.user!.title;
      control2.text = widget.user!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Update_Control(),
      child: Consumer<Update_Control>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Update user"),
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      My_Textfield(hint: "Title", con: control1),
                      My_Textfield(
                        hint: "Body",
                        con: control2,
                      ),
                    ],
                  ),
                ),
                model.isloading
                    ? Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(.3),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var title = control1.text.trim();
              var body = control2.text.trim();
              if (title.isNotEmpty && body.isNotEmpty) {
                model.update_user(title, body, widget.user!.id).then((value) {
                  if (value.isNotEmpty) {
                    Navigator.pop(context, "refresh");
                  }
                });
              }
            },
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
