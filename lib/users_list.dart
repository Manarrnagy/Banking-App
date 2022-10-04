import 'dart:ui';

import 'package:banking_app/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sqldb.dart';

///List of all users
class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List users = [];
//reading data of users from database
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'users' ");
    users.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  void initState() {
    readData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users List',
          textAlign: TextAlign.center,
        ),
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(50, 81, 180, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: new Radius.circular(30),
          ),
        ),
      ),
      //-----------------------------drawer-----------------------
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(96, 143, 223, 1),
                Color.fromRGBO(230, 239, 255, 1),
                Color.fromRGBO(96, 143, 223, 1),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.14,
                // margin: EdgeInsets.only(bottom: 20),

                decoration: const BoxDecoration(
                    color: Color.fromRGBO(50, 81, 180, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(10))),
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0),
                    child: ListTile(
                      title: Text(
                        "Banking App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.monetization_on_outlined,
                        size: 35,
                        color: Colors.yellow,
                      ),
                      horizontalTitleGap: 5,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text("Users", style: TextStyle(fontSize: 20)),
                leading: const Icon(
                  Icons.people_outline_rounded,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('userslist');
                },
                hoverColor: Colors.grey,
              ),
              ListTile(
                title: Text("Transfers", style: const TextStyle(fontSize: 20)),
                leading: const Icon(
                  Icons.compare_arrows_rounded,
                  size: 30,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('transferslist');
                },
                hoverColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: isLoading == true

          ///------------------------ users list---------------------------
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.deepPurple,
              backgroundColor: Colors.grey,
            ))
          : Container(
              child: ListView.builder(
                itemCount: users.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      color: Color.fromRGBO(230, 239, 255, 1),
                      child: InkWell(
                        child: ListTile(
                            title: Text("${users[i]['name']}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //--------------------------Balance-----------------------
                                Text("${users[i]['currentBalance']}",
                                    style: TextStyle(fontSize: 16)),
                                const Text("\$",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  UserProfile(user: users[i])));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
