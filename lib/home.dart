import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //------------------------------------HOME IMAGE AND GRADIENT BACKGROUND-------------------------
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            // margin: EdgeInsets.only(bottom: 20),

            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    //color: Color.fromRGBO(145, 234, 232, 1).withOpacity(0.5),
                    color: Colors.white,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.contain, image: AssetImage("images/bank7.png")),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.cyan,
                    Color.fromRGBO(230, 239, 255, 1),
                    Color.fromRGBO(96, 143, 223, 1),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: const Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 160.0),
                child: Text(
                  "Banking App",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ),
          ),

          //-----------------------------USERS LIST BUTTON----------------------------
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed("userslist");
            },
            color: const Color.fromRGBO(50, 81, 180, 1),
            minWidth: 200,
            height: 50,
            child: const Text(
              "Show Users",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            splashColor: const Color.fromRGBO(251, 102, 10, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
          )
        ],
      ),
    );
  }
}
