import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_active/rendomfun.dart';
import 'package:mobile_active/sqldb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDA5gper8wVlFcJSWPMGsKoi7Rn-zUCZvw',
          appId: '1:390495442614:android:06354c43e8f6717e98f817',
          messagingSenderId: '390495442614',
          projectId: 'keying-5ab43'));
  runApp(const MyApp());
}

//state ful widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//class in  state ful

class _MyAppState extends State<MyApp> {
  charter keys = charter();
  sqldb mydb = sqldb();
  String view = "your keys is";
  final TextEditingController keysnumber = TextEditingController();
  CollectionReference keysuser =
      FirebaseFirestore.instance.collection('keysuser');

  Future<void> addUser(String numb) {
    // Call the user's CollectionReference to add a new user
    return keysuser
        .add({"keys": numb})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.fill,
                )),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        left: 30,
                        height: 200,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-1.png'))),
                        )),
                    Positioned(
                        left: 220,
                        height: 150,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-2.png'))),
                        )),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            'ACTIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 140, 251, 1),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: TextField(
                        readOnly: true,
                        controller: keysnumber,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                await FlutterClipboard.copy(view);
                              },
                              child: Icon(Icons.copy),
                            ),
                            border: InputBorder.none,
                            hintText: view,
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF8F8CFB),
                            Color.fromRGBO(143, 140, 251, 22)
                          ]),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: MaterialButton(
                            onPressed: () async {
                              String firest = keys.generateRandomCharacter();
                              String two = keys.generateRandomNumberString();
                              String tree = keys.generateRandomCharacter();
                              setState(() {
                                view = firest + two + tree;
                                addUser(view);
                              });
                              mydb.insertData(view);
                              // int respo = await mydb.Insertdata(
                              //     "INSERT INTO 'FIRESTTABLE' ('KEY') VALUES ('$view') ");
                              List<Map<String, dynamic>> results =
                                  await mydb.selectData();
                              print(results);

                              print(view);
                            },
                            child: Text(
                              'Generat Key',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
