import 'package:flutter/material.dart';
import 'package:todo/screens/taskpage.dart';
import 'package:todo/widget.dart';


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
                        image: AssetImage("assets/images/a.png"
                        ),
                      ),
                    ),
                     Expanded(
                     child: ScrollConfiguration(behavior: NoGlowBehaviour(),
                      child: ListView(
                        children: [
                          TaskCardWidget(title: "get start", desc: " hello user",),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                      ],
                      ),
                    ),
                  ),
                  ],
                ),
              Positioned(
                bottom: 24,
                right: 0,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => Taskpage(),
                    ),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7349FE),Color(0xFF643FDB)
                        ],
                        begin: Alignment(0,-1),
                        end: Alignment(0,1),
                      ),

                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      image: AssetImage(
                          "assets/images/s.png"
                      ),
                    ),
                  ),
                ),
              ),
              ],
            )),
      ),
    );
  }
}
