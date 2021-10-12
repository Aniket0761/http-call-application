import 'package:flutter/material.dart';
import 'package:test_application/FloatingButton.dart';
import 'package:test_application/HomePage.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      drawer: Drawer(
        child: Container(
          color: Colors.blue.shade100,
          child: ListView(
            children: [
              Container(
                height: 100,
              ),
              Column(
                children: Iterable<int>.generate(9).map((e) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              border: Border.symmetric(
                                  horizontal:
                                      BorderSide(color: Colors.black45))),
                          height: 50,
                          child: Center(
                              child: Text(
                            'Link $e',
                            style: TextStyle(fontSize: 16),
                          )),
                          // color: Colors.blue.shade300,
                        ),
                      ),
                    ],
                  );
                }).toList(),

                //   Container(
                //     decoration: BoxDecoration(
                //         color: Colors.blue.shade300,
                //         border: Border.symmetric(
                //             horizontal: BorderSide(color: Colors.black45))),
                //     height: 50,
                //     // color: Colors.blue.shade300,
                //   ),
                //   Container(
                //     decoration: BoxDecoration(
                //         color: Colors.blue.shade300,
                //         border: Border.symmetric(
                //             horizontal: BorderSide(color: Colors.black45))),
                //     height: 50,
                //     // color: Colors.blue.shade300,
                //   ),
                // ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
      ),
      body: SafeArea(
        child: HomePage(),
      ),
      floatingActionButton: CreateFloatingButton(),
    );
  }
}
