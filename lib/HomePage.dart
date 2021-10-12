import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<List<dynamic>> getResources() async {
  var url = 'https://jsonplaceholder.typicode.com/posts';
  final response = await http.read(Uri.tryParse('$url'));
  final result = jsonDecode(response);
  return result;
}

Future<String> updateResources(
    int id, String title, String body, int userId) async {
  var url = 'https://jsonplaceholder.typicode.com/posts/1';
  final response = await http.put(
    Uri.tryParse('$url'),
    body: json.encode({
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    }),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  // final result = jsonDecode(response.body);
  // print(result);
  return response.statusCode.toString();
}

Future<String> deleteResources(int id) async {
  var url = 'https://jsonplaceholder.typicode.com/posts/$id';
  final response = await http.delete(
    Uri.tryParse('$url'),
  );
  // final result = jsonDecode(response.body);
  // print(result);
  return response.statusCode.toString();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: getResources(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.map((e) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        enableDrag: false,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (
                            BuildContext context,
                            StateSetter setState,
                          ) {
                            return Scaffold(
                              backgroundColor: Colors.lightBlue.shade100,
                              body: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: CircleAvatar(
                                            child: Text(
                                              '${e['id']}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${e['title']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${e['body']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.grey,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          var result = await updateResources(
                                              1, 'foo', 'bar', 1);
                                          print(int.parse(result));
                                          if (int.parse(result) >= 200 &&
                                              int.parse(result) <= 299) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                padding: EdgeInsets.zero,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                content: Text(
                                                  'Successfully Updated!',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(
                                                    milliseconds: 1800),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                padding: EdgeInsets.zero,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                content: Text(
                                                  'There was an error updating.\n Please try again later!',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child:
                                                Center(child: Text('UPDATE'))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Material(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.red,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          var result =
                                              await deleteResources(e['id']);
                                          print(int.parse(result));
                                          if (int.parse(result) >= 200 &&
                                              int.parse(result) <= 299) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                padding: EdgeInsets.zero,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                content: Text(
                                                  'Successfully Deleted!',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(
                                                    milliseconds: 1800),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                padding: EdgeInsets.zero,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                content: Text(
                                                  'There was an error deleting.\n Please try again later!',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child:
                                                Center(child: Text('DELETE'))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.blue.shade100,
                    shadowColor: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Center(
                              child: CircleAvatar(
                                child: Text(
                                  '${e['id']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${e['title']}',
                            ),
                          )
                        ],

                        // trailing: Text(
                        //   '${e['userId']}',
                        // ),
                        // subtitle: Text(
                        //   '${e['body']}',
                        // ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
