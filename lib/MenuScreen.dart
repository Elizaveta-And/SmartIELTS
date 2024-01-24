import 'package:flutter/material.dart';

class Menu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 80, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 1, height: 1,),
                  Text(
                    "MENU",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 35,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                      Text("About IELTS", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                    Text("Speaking: Question types", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                    Text(
                      "Listening: Question types", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                    Text(
                      "Reading: Question types", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_right, size: 40, color: Colors.purple,),
                    Text(
                      "Writing: Question types", style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}