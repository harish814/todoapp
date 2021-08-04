import 'package:flutter/material.dart';
import 'package:todoapp/components/components.dart';
import 'package:todoapp/components/widgets.dart';
import 'package:todoapp/db/todo_today_db.dart';
import 'package:todoapp/db/todo_tommarow_db.dart';
import 'package:todoapp/model/todo.dart';

class TodoHomeScreen extends StatefulWidget {
  @override
  _TodoHomeScreenState createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final TextEditingController _controller = TextEditingController();

  late List<todo> todoList;
  bool _isLoading = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    refreshTodoList();
    selectedValue = single.first;
  }

  void dispose() {
    TodoTodayDbNew.instance.close();
    super.dispose();
  }

  Future refreshTodoList() async {
    setState(() {
      _isLoading = true;
    });
    this.todoList = await TodoTodayDbNew.instance.readAllTodo();
    setState(() {
      _isLoading = false;
    });
  }

  late String selectedValue;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          backgroundColor: bgBlack,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 0,
                    ),
                    insets: EdgeInsets.all(0),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Today',
                        style: mainHeading,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Tommorow',
                        style: mainHeading,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TabBarView(
            children: [
              FutureBuilder<List<todo>>(
                future: TodoTodayDbNew.instance.readAllTodo(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<todo>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        todo item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            onDoubleTap: () {
                              TodoTodayDbNew.instance.delete(item.id!);
                              refreshTodoList();
                            },
                            onLongPress: () async {
                              final note = todo(
                                todoItem: item.todoItem,
                                catogary: item.catogary,
                                ischecked: false,
                              );
                              await TodoTommarowDbNew.instance.create(note);
                              await TodoTodayDbNew.instance.delete(item.id!);
                              refreshTodoList();
                            },
                            child: ListTile(
                                leading: CircleCategory(item: item),
                                title: TextTodo(item: item),
                                trailing: Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.white),
                                  value: item.ischecked,
                                  onChanged: (s) async {
                                    final note = todo(
                                        todoItem: item.todoItem,
                                        catogary: item.catogary,
                                        ischecked: s!,
                                        id: item.id);
                                    await TodoTodayDbNew.instance.update(note);
                                    refreshTodoList();
                                  },
                                )),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List<todo>>(
                future: TodoTommarowDbNew.instance.readAllTodo(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<todo>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        todo item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            onDoubleTap: () {
                              TodoTommarowDbNew.instance.delete(item.id!);
                              refreshTodoList();
                            },
                            onLongPress: () async {
                              final note = todo(
                                todoItem: item.todoItem,
                                catogary: item.catogary,
                                ischecked: false,
                              );
                              await TodoTodayDbNew.instance.create(note);
                              await TodoTommarowDbNew.instance.delete(item.id!);
                              refreshTodoList();
                            },
                            child: ListTile(
                                leading: CircleCategory(item: item),
                                title: TextTodo(item: item),
                                trailing: Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.white),
                                  value: item.ischecked,
                                  onChanged: (s) async {
                                    final note = todo(
                                        todoItem: item.todoItem,
                                        catogary: item.catogary,
                                        ischecked: s!,
                                        id: item.id);
                                    await TodoTommarowDbNew.instance
                                        .update(note);
                                    refreshTodoList();
                                  },
                                )),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: bgBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => StatefulBuilder(
                        builder: (BuildContext context, StateSetter state) =>
                            SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'What do you need to get done',
                                              style: textAddScreen,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xff37474f),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: TextField(
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'Abril'),
                                                cursorColor: Colors.white,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                  hintText: 'Enter Something',
                                                ),
                                                maxLines: 5,
                                                onChanged: (todo) {
                                                  setState(() {
                                                    _text = todo;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Select a Category',
                                                  style: textAddScreen,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 100,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: single.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: index % 2 ==
                                                                    0
                                                                ? Color(
                                                                    0xff082032)
                                                                : Color(
                                                                    0xff334756),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Radio<String>(
                                                                  activeColor:
                                                                      Colors
                                                                          .white,
                                                                  value: single[
                                                                      index],
                                                                  groupValue:
                                                                      selectedValue,
                                                                  onChanged:
                                                                      (value) {
                                                                    state(() {
                                                                      selectedValue =
                                                                          value!;
                                                                    });
                                                                    print(
                                                                        selectedValue);
                                                                  }),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                width: 80,
                                                                child: Center(
                                                                  child: Text(
                                                                    single[
                                                                        index],
                                                                    softWrap:
                                                                        true,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Abril',
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Add to List',
                                                  style: textAddScreen,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            if (_text != '') {
                                                              final note = todo(
                                                                  todoItem:
                                                                      _text,
                                                                  catogary:
                                                                      selectedValue,
                                                                  ischecked:
                                                                      false);
                                                              await TodoTodayDbNew
                                                                  .instance
                                                                  .create(note);
                                                              refreshTodoList();
                                                              _controller
                                                                  .clear();
                                                              setState(() {
                                                                _text = '';
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xff082032),
                                                                      title:
                                                                          Center(
                                                                        child:
                                                                            new Text(
                                                                          "Please Fill the Fields",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            }
                                                          },
                                                          child: Text(
                                                            'TODAY',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            if (_text != '') {
                                                              final note = todo(
                                                                  todoItem:
                                                                      _text,
                                                                  catogary:
                                                                      selectedValue,
                                                                  ischecked:
                                                                      false);
                                                              await TodoTommarowDbNew
                                                                  .instance
                                                                  .create(note);
                                                              refreshTodoList();
                                                              _controller
                                                                  .clear();
                                                              setState(() {
                                                                _text = '';
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xff082032),
                                                                      title:
                                                                          Center(
                                                                        child:
                                                                            new Text(
                                                                          "Please Fill the Fields",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            }
                                                          },
                                                          child: Text(
                                                            'TOMARROW',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Abril',
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ));
            }),
      ),
    );
  }
}
