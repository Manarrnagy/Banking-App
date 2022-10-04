import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sqldb.dart';

///Displays All transfers recorded in database
class TransfersList extends StatefulWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
  @override
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List transfers = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'transfers' ");
    transfers.addAll(response);
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
            'Transfers',
            textAlign: TextAlign.center,
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromRGBO(50, 81, 180, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: new Radius.circular(30),
            ),
          ),
        ),
        //------------------------------------Drawer-----------------
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
                  title: Text("Users", style: const TextStyle(fontSize: 20)),
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
                  title: Text("Transfers", style: TextStyle(fontSize: 20)),
                  leading: const Icon(
                    Icons.compare_arrows_rounded,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('transferslist');
                  },
                  hoverColor: Colors.grey,
                )
              ],
            ),
          ),
        ),
        //---------------------------------------List of transactions---------------------------------
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.deepPurple,
                backgroundColor: Colors.grey,
              ))
            : Container(
                child: ListView.builder(
                  itemCount: transfers.length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        color: Color.fromRGBO(230, 239, 255, 1),
                        child: ListTile(
                          title: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${transfers[i]['senderName']}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Icon(
                                        Icons.arrow_right_alt_rounded,
                                        size: 40,
                                        color: Colors.blueAccent,
                                      ),
                                      Text("${transfers[i]['receiverName']}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //     //--------------------------Balance-----------------------
                                    Text(
                                        "Transfer Value: ${transfers[i]['transferValue']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey)),
                                    const Icon(
                                      CupertinoIcons.money_dollar,
                                      color: Colors.green,
                                    ),
                                    // Text("\$",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
