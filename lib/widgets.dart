import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  String?  title;
  String?  desc;
  TaskCardWidget({Key? key,   this.title,  this.desc}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Colors.deepPurpleAccent[700],
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              desc ?? "(No Description added")",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.deepPurpleAccent[700],
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
class TodoWidget extends StatelessWidget {
final  String? text;
final bool isDone;

  const TodoWidget({Key? key, this.text,  required this.isDone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(
              right: 12,
            ),
            decoration: BoxDecoration(
              color: isDone ? Color(0xFF7349FE):Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isDone ? null: Border.all(
                color:Color(0xFF86829D),
                width: 1.5,
              ),
            ),
            child: Image(
              image: AssetImage(
                  "assets/images/check-16.gif"
              ),
            ),
          ),
          Text(
           text ?? "(Unnamed Todo)",
            style: TextStyle(
              color:isDone? Color(0xFF211551): Color(0xFF86829D),
              fontSize: 16,
              fontWeight:isDone?  FontWeight.bold: FontWeight.w500 ,
            ),
          ),
        ],
      ),
    );
  }

}

class NoGlowBehaviour extends ScrollBehavior{
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}