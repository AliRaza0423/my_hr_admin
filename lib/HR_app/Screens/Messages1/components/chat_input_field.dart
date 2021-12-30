import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/components/message_services.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/components/model.dart';
import 'package:hr_admin/HR_app/Screens/Messages1/message_screen.dart';
import 'package:hr_admin/HR_app/Screens/Pg1_Signin.dart';
import 'package:hr_admin/HR_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  ChatInputField({
    this.userID,
    Key key,
  }) : super(key: key);

  String userID;
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  //------------------------
  String username = 'Ali';
  CollectionReference Chat = FirebaseFirestore.instance.collection('Chat');

  Future<void> add(String userID, String body, DateTime date) {
    return Chat.add({'userID': userID, 'body': body, 'date': date});
  }
  //-----------------------

  File _image;
  TextEditingController _controller = new TextEditingController();
  bool istyping = false;

  Future getimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    File imagetemp = File(image.path);
    setState(() {
      this._image = imagetemp;
      addimage(this._image);
      MessagesScreen.length.value += 1;
      Navigator.pop(context);
    });
  }

  addmsg(String text) {
    myMsg.add(new MyMessage(
      name: 'ali',
      issender: true,
      date: DateTime.now(),
      text: text,
      messageType: ChatMessageType.text,
    ));
  }

  addimage(File image) {
    myMsg.add(new MyMessage(
      name: 'ali',
      issender: true,
      date: DateTime.now(),
      image: image,
      messageType: ChatMessageType.image,
    ));
  }

  addaudio() {
    myMsg.add(new MyMessage(
      name: 'ali',
      issender: true,
      date: DateTime.now(),
      messageType: ChatMessageType.audio,
    ));
  }

  @override
  // void initState() async{
  //   // TODO: implement initState
  //   super.initState();
  // userID = await getdata('userID');

  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: kPrimaryColor,
      elevation: 5,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        child: SafeArea(
            child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.64),
              ),
              onPressed: () {},
            ),
            SizedBox(width: 5),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(width: kDefaultPadding / 4),
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type Message',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) istyping = false;
                          if (value.isNotEmpty) istyping = true;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints(minHeight: 80),
                        context: context,
                        builder: (context) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      getimage();
                                      // MessagesScreen.length.value += 1;
                                    });
                                  },
                                  icon: Icon(Icons.open_in_browser),
                                  label: Text('Browse')),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  if (istyping == true)
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.white,
                        onPressed: () {
                          print(_controller.text);
                          MessagesScreen.length.value += 1;
                          setState(() {
                            add(widget.userID, _controller.text,
                                DateTime.now());
                            send(username, _controller.text, null);
                            // addmsg(_controller.text);
                            _controller.clear();
                            istyping = false;
                          });
                          print(_controller.text);
                          print(count);
                        },
                      ),
                    ),
                  if (istyping == false)
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.mic),
                        color: Colors.white,
                        onPressed: () {
                          MessagesScreen.length.value += 1;
                          setState(() {
                            addaudio();
                          });
                        },
                      ),
                    ),
                ],
              ),
            )),
          ],
        )),
      ),
    );
  }
}
