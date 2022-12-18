import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_firebase/loading.dart';
import 'package:to_do_list_with_firebase/model/todo.dart';
import 'package:to_do_list_with_firebase/services/database_services.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late final Todo oldTodo;
  bool isComplet = false; 
  bool isUpdated = false; // just for now
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController UpdatedtodoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(213, 255, 254, 254),
      body: SafeArea(
        child: StreamBuilder<List<dynamic>>(
            stream: DatabaseService().listTodos(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              }
              List? todos = snapshot.data;
              return Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "TO DO App",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13.0),
                                
                          ),
                          width: 275,
                          child: TextFormField(
                            controller: todoTitleController,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.2,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Type something Here ...",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13.0),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        IconButton(
                            onPressed: () async {
                              
                              if (todoTitleController.text.isNotEmpty) {
                                await DatabaseService().createNewTodo(
                                    todoTitleController.text.trim());
                              }
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.black,
                              size: 42,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Color.fromARGB(213, 255, 254, 254),
                        ),
                        shrinkWrap: true,
                        itemCount: todos!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13.0),
                              border: Border.all(color: Colors.white),
                            ),
                            child: ListTile(
                              onTap: () {
                                DatabaseService().completTask(todos[index].uid);
                              },
                              leading: Container(
                                padding: EdgeInsets.all(2),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: todos[index].isComplet
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      )
                                    : Container(),
                              ),
                              title: Text(
                                todos[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Wrap(
                                spacing: 12, // space between two icons
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () async {
                                     
                              
                                    },
                                    icon: Icon(Icons.edit,color: Colors.black,size: 25,)),
                                  IconButton(
                                    onPressed: () async {
                                      
                              await DatabaseService()
                                  .removeTodo(todos[index].uid);
                                    },
                                    icon: Icon(CupertinoIcons.delete_solid,color: Colors.black,size: 25,)), // icon-2
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
