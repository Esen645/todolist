import 'package:flutter/material.dart';
import 'package:todo/widget.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                      top: 24,
                      bottom: 6,

                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                           Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage(
                                  "assets/images/left-ok.png"
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Task Title...",
                              border: InputBorder.none,
                            ) ,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                        bottom: 12.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Description for the task... ",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                      ) ,
                    ),
                  ),
                  TodoWidget(
                    text:"creat your first task ",
                    isDone: true,
                  ),
                  TodoWidget(
                      text:"creat your first todo as well" ,
                    isDone: false
                  ),
                  TodoWidget( text: "just another todo",
                  isDone: false,),
                  TodoWidget( isDone: true,),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
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
                      color: Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image(
                      image: AssetImage(
                          "assets/images/delete-16.gif"
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
