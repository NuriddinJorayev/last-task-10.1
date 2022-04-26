import 'package:flutter/material.dart';
import 'package:last_prvoder/controllers/home_control.dart';
import 'package:last_prvoder/pages/create_page.dart';
import 'package:last_prvoder/pages/update_page.dart';
import 'package:last_prvoder/views/home_view.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var list_key = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => Home_control(),
      child: Consumer<Home_control>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color.fromARGB(255, 51, 48, 48),
          appBar: AppBar(
            title: Text("Provider = ${model.base_list.length}"),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            child: model.isLoading
                ? Container(
                    height: height,
                    width: width,
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : model.base_list.isNotEmpty
                    ? AnimatedList(
                        key: list_key,
                        initialItemCount: model.base_list.length,
                        itemBuilder: (context, index, animation) => UserItem(
                          width: width,
                          index: index,
                          u: model.base_list[index],
                          model: model,
                          animation: animation,
                          Remove: (all_list) {
                            final removed_item = model.base_list[index];
                            model.list_item_delete(index, removed_item);
                            list_key.currentState!.removeItem(
                              index,
                              (context, animation) => UserItem(
                                  width: width,
                                  index: index,
                                  u: removed_item,
                                  model: model,
                                  animation: animation,
                                  Remove: (ll) {}),
                            );
                          },
                        ),
                      )
                    : Text("no data"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Create_page()))
                  .then((value) {
                if (value == "created") {
                  model.initialize();
                }
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
