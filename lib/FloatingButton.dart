import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;

class CreateFloatingButton extends StatefulWidget {
  @override
  _CreateFloatingButtonState createState() => _CreateFloatingButtonState();
}

class _CreateFloatingButtonState extends State<CreateFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white70,
      onPressed: () {
        var baseDialog = BaseAlertDialog(
            head: "Add New Content",
            yesOnPressed: (String userId, String title, String body) async {
              var url = 'https://jsonplaceholder.typicode.com/posts';
              final response = await http.post(
                Uri.tryParse('$url'),
                body: json.encode({
                  // 'id': id,
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
              var result = response.statusCode.toString();
              if (int.parse(result) >= 200 && int.parse(result) <= 299) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1000),
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.zero,
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width / 2,
                    content: Text(
                      'Resource Successfully Created!',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1800),
                    backgroundColor: Colors.grey.shade200,
                    padding: EdgeInsets.zero,
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width / 1.5,
                    content: Text(
                      'There was an error creating.\n Please try again later!',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            noOnPressed: () {
              Navigator.pop(context);
            },
            yes: "Yes",
            no: "No");
        showDialog(
            context: context, builder: (BuildContext context) => baseDialog);
      },
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  // Color _color = Colors.grey;

  // ignore: unused_field
  // late String _content;
  String userId;
  String title;
  String body;
  String _yes;
  String _no;
  Function _yesOnPressed;
  Function _noOnPressed;
  String head;

  BaseAlertDialog(
      {
      // required String content,
      String userId,
      String title,
      String body,
      String head,
      Function yesOnPressed,
      Function noOnPressed,
      String yes = "Yes",
      String no = "No"}) {
    this.head = head;
    this.title = title;
    this.body = body;
    this.userId = userId;
    // this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        this.head,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white70),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              // onEditingComplete: () => FocusScope.of(context).nextFocus(),
              autocorrect: false,
              onSaved: (newValue) {
                userId = newValue.toString();
                if (userId == '') {
                  userId = '';
                }
              },
              onChanged: (value) {
                userId = value;
                if (userId == '') {
                  userId = userId;
                }
              },
              decoration: textField(context, '', 'User ID', userId),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              // onEditingComplete: () => FocusScope.of(context).nextFocus(),
              autocorrect: false,
              onSaved: (newValue) {
                title = newValue.toString();
                if (title == '') {
                  title = title;
                }
              },
              onChanged: (value) {
                title = value;
                if (title == '') {
                  title = title;
                }
              },
              decoration: textField(context, '', 'Title', title),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              // onEditingComplete: () => FocusScope.of(context).nextFocus(),
              autocorrect: false,
              onSaved: (newValue) {
                body = newValue.toString();
                if (body == '') {
                  body = '';
                }
              },
              onChanged: (value) {
                body = value;
                if (body == '') {
                  body = body;
                }
              },
              decoration: textField(context, '', 'Body', body),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade300,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        Material(
          color: Colors.blue.shade800,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: MaterialButton(
            child: Text(this._no),
            textColor: Colors.white70,
            onPressed: () {
              this._noOnPressed();
            },
          ),
        ),
        Material(
          color: Colors.blue.shade800,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: MaterialButton(
            child: new Text(this._yes),
            textColor: Colors.white70,
            onPressed: () {
              this._yesOnPressed(userId, title, body);
            },
          ),
        ),
      ],
    );
  }
}

InputDecoration textField(BuildContext context, icon, label, hint) {
  return InputDecoration(
    fillColor: Colors.blue.shade100,
    filled: true,
    prefixIcon: icon == ''
        ? null
        : Icon(
            icon,
            color: Colors.blue.shade700,
          ),
    // fillColor: Colors.white,
    hintText: hint,
    labelText: label,
    labelStyle: TextStyle(
      color: Colors.blue.shade600,
    ),
    contentPadding: EdgeInsets.only(bottom: 10.0, left: 22.0, right: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade900),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  );
}
