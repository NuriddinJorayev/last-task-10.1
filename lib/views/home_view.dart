import 'package:flutter/material.dart';
import 'package:last_prvoder/models/user.dart';
import 'package:last_prvoder/pages/update_page.dart';

import '../controllers/home_control.dart';

class UserItem extends StatefulWidget {
  final double width;
  final User u;
  final int index;
  final Home_control model;
  final Animation<double> animation;
  final Function(List<User> users) Remove;
  const UserItem(
      {Key? key,
      required this.width,
      required this.u,
      required this.index,
      required this.model,
      required this.animation,
      required this.Remove})
      : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double x = 0.0;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: x, end: 0.0).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: widget.animation,
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                  bottom: 20,
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                  )),
              GestureDetector(
                onHorizontalDragUpdate: (d) {
                  change(widget.width, d.localPosition.dx);
                },
                onHorizontalDragEnd: (d) async {
                  if (x < ((widget.width - 40) / 2) + 100) {
                    await controller.forward().then((value) {
                      change(widget.width, 0.0);
                      controller.reset();
                    });
                  } else {
                    // var list = widget.model.list_item_delete(widget.index);
                    change(widget.width, 0.0);
                    widget.Remove(widget.model.base_list);
                  }
                },
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (con, child) => Transform.translate(
                    offset: Offset(-animation.value, 0),
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.all(20),
                      child: ListTile(
                        title: Text(widget.u.title),
                        subtitle: Text(widget.u.body),
                        trailing: IconButton(
                          splashRadius: 25,
                          splashColor: Color.fromARGB(255, 54, 51, 51),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UpdatePage(
                                          user: widget.u,
                                        ))).then((value) {
                              if (value == "refresh") {
                                widget.model.initialize();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 26,
                            color: Color.fromARGB(255, 51, 48, 48),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  change(double width, double x1) {
    setState(() {
      if (x1 != 0) {
        x = width - x1;
      } else {
        x = 0;
      }
      animation = Tween<double>(begin: x, end: 0.0).animate(controller);
    });
  }
}
