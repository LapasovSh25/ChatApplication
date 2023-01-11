import 'dart:async';

import 'package:checkingfile/service/new_service.dart';
import 'package:checkingfile/view/chat_page.dart';
import 'package:checkingfile/view/info_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription2;
  bool isConnected = false;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: NewService.getNewService(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.menu_outlined,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 125),
                            child: Text(
                              "Conversations",
                              style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 435,
                        height: 49,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            showCursor: false,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.only(top: 10),
                                hintText: "Search Conversations",
                                hintStyle:
                                    GoogleFonts.notoSansAnatolianHieroglyphs(
                                        textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(174, 181, 197, 1),
                                )),
                                filled: true,
                                fillColor: Color.fromRGBO(231, 236, 246, 1),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24.5),
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    flex: 6,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(),
                                ));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://source.unsplash.com/random/$index",
                              ),
                              radius: 25,
                            ),
                            title: Text(
                              NewService.userBox!.get(index)!.name.toString(),
                              style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            subtitle: Text(
                              NewService.userBox!.get(index)!.phone.toString(),
                              style: GoogleFonts.notoSansAnatolianHieroglyphs(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                           
                          ),
                        );
                      },
                      itemCount: NewService.userBox!.length,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  checkConnection() {
    _connectivitySubscription2 =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        isConnected = true;
        Fluttertoast.showToast(
          msg: "You are online",
        );
        setState(() {});
      } else {
        isConnected = false;
        Fluttertoast.showToast(msg: "You are offline");
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription2!.cancel();
    super.dispose();
  }
}
