import 'package:flutter/material.dart';
import 'package:wave/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final meesegetextcontroller = TextEditingController();

  String messegetext;

  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  void getcurrentuser() async {
    try {
      final user =_auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Messegesstream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: meesegetextcontroller,
                      onChanged: (value) {
                        messegetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      meesegetextcontroller.clear();
                      _firestore.collection('messeges').add({
                        'sender': loggedInUser.email,
                        'text': messegetext,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messegesstream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messeges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.brown,
              ),
            );
          }
          final messeges = snapshot.data.docs.reversed;
          List<Messebubble> messegewidgets = [];
          for (var messege in messeges) {
            final messegetxt = messege.get('text');
            final messegesender = messege.get('sender');
            final currentuser = loggedInUser.email;
            final messegewidget = Messebubble(
                sender: messegesender,
                text: messegetxt,
                isme: currentuser == messegesender);
            messegewidgets.add(messegewidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messegewidgets,
            ),
          );
        });
  }
}

class Messebubble extends StatelessWidget {
  Messebubble({this.sender, this.text, this.isme});
  final String sender;
  final String text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 10,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Material(
              elevation: 5,
              borderRadius: isme
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isme ? Colors.cyanAccent : Colors.white,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '$text',
                  style: TextStyle(
                    color: isme ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
