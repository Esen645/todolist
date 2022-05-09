import 'package:flutter/material.dart';
import 'package:todo/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            color: Color(0xFFF6F6F6),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Image(
                        width: 150,
                        height: 150,
                        image: AssetImage("assets/images/a.png"),
                      ),
                    ),
                    TaskCardWidget(
                      title: "Get Started",
                      desc:
                          "Hello User Welcome to App this is a default task that you can edit of delete to start using the app",
                    ),
                       TaskCardWidget(),
                       TaskCardWidget(),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.deepPurpleAccent[700]),
                    child: Image(image: AssetImage("assets/images/s.png")),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
