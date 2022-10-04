import 'package:flutter/material.dart';

import 'recievers_list.dart';

class UserProfile extends StatefulWidget {
  final user;
  const UserProfile({Key? key, this.user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User's profile",
          textAlign: TextAlign.center,
        ),
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(50, 81, 180, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            heightFactor: 1.5,
            child: CircleAvatar(
              // Person Avatar
              radius: 70,
              backgroundImage: AssetImage('images/avatar.jpg'),
            ),
          ),

          //----------------Info-------------
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            padding: const EdgeInsets.only(top: 25, bottom: 25, left: 30),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(230, 239, 255, 1) //light purple
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //----------------------------------Current Balance---------------------
                Row(
                    // mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(Icons.monetization_on,
                          size: 30, color: Color.fromRGBO(50, 81, 180, 1)),
                      const Text(
                        "Current Balance: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${widget.user['currentBalance']}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ]),

                //-------------------------------------------Email------------------------
                Row(children: [
                  const Icon(Icons.email,
                      size: 30, color: Color.fromRGBO(50, 81, 180, 1)),
                  const Text(
                    " Email: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.user['email']}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ]),

                //---------------------------------------Phone--------------------------------

                Row(children: [
                  const Icon(Icons.phone,
                      size: 30, color: Color.fromRGBO(50, 81, 180, 1)),
                  const Text(
                    "Phone: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ${widget.user['phone']}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  )
                ]),
              ],
            ),
          ),
          //--------------------------------Transfer Button ---------------------------------
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReceiversList(sender: widget.user)));
              },
              child: const Text(
                "Transfer Money",
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(50, 81, 180, 1), elevation: 5)),
        ],
      ),
    );
  }
}
