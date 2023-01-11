import 'dart:async';

import 'package:checkingfile/model/new_model.dart';
import 'package:checkingfile/model/new_search_model.dart';
import 'package:checkingfile/service/new_service.dart';
import 'package:checkingfile/view/chat_page.dart';
import 'package:checkingfile/view/info_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<NewModel> _searchedData = [];
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
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
                              "Contacts",
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
                                hintText: "Search Contact",
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
                                  builder: (context) => InfoPage(
                                      data: NewService.userBox!.getAt(index)!),
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
                            trailing: Wrap(children: [
                              Icon(
                                Icons.phone,
                                color: Color.fromRGBO(171, 178, 192, 1),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(),
                                      ));
                                },
                                child: ImageIcon(
                                  AssetImage('assets/chat.png'),
                                  color: Color.fromRGBO(171, 178, 192, 1),
                                ),
                              ),
                            ]),
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
    _connectivitySubscription =
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
    _connectivitySubscription!.cancel();
    super.dispose();
  }
}
