import 'package:checkingfile/model/new_model.dart';
import 'package:checkingfile/service/new_service.dart';
import 'package:checkingfile/view/bottomnavigationbar.dart';
import 'package:checkingfile/view/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  final NewModel data;
  InfoPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/cancel.png'),
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "block",
                        style: GoogleFonts.notoSansAnatolianHieroglyphs(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  value: 1,
                )
              ],
            )
          ],
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Color(0xffE5E5E5),
          centerTitle: true,
          title: Text(
            "User Information",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
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
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 50),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 115,
                            ),
                            child: Container(
                              width: 337,
                              height: 309,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Container(
                                    width: 183,
                                    height: 183,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://source.unsplash.com/random'),
                                            fit: BoxFit.fill),
                                        shape: BoxShape.circle,
                                        color: Colors.yellow),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Column(
                                    children: [
                                      Text(
                                        data.name.toString(),
                                        style: GoogleFonts
                                            .notoSansAnatolianHieroglyphs(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "Here is my status.",
                                        style: GoogleFonts
                                            .notoSansAnatolianHieroglyphs(
                                          color:
                                              Color.fromRGBO(162, 169, 183, 1),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        children: [
                                          ImageIcon(
                                            AssetImage('assets/phone.png'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            data.phone.toString(),
                                            style: GoogleFonts
                                                .notoSansAnatolianHieroglyphs(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          ImageIcon(
                                            AssetImage('assets/email.png'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            data.email.toString(),
                                            style: GoogleFonts
                                                .notoSansAnatolianHieroglyphs(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 24),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatPage(),
                                              ));
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 37,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              color: Colors.blue),
                                          child: Center(
                                              child: Text(
                                            "Message",
                                            style: GoogleFonts
                                                .notoSansAnatolianHieroglyphs(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 140,
                                        height: 37,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text(
                                            "Call",
                                            style: GoogleFonts
                                                .notoSansAnatolianHieroglyphs(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
