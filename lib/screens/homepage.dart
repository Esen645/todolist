import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/model/task.dart';
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
            color: const Color(0xFFF6F6F6),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(  top: 32.0,
                      bottom: 32.0,),
                      child: Image(
                        width: 150,
                        height: 150,
                        image: AssetImage("assets/images/a.png"
                        ),
                      ),
                    ),
                     Expanded(
                     child: FutureBuilder(

                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot<List<Task>> snapshot){
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount:  snapshot.hasData ? snapshot.data!.length : 0,
                              itemBuilder: (context, index){
                                          return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data![index],
                                      ),
                                    ),
                                  ).then(
                                        (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data![index].title,
                                  desc:  snapshot.data![index].description,
                                ),
                              );
                            );
                          }
                         ),
                      );
                    },  
                  ),
                )
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
                    ).then((value){
                      setState(() {

                      }
                      );
                    }
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
                          "assets/images/plus.png"
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
