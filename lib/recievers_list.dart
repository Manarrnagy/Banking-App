import 'package:banking_app/sqldb.dart';
import 'package:flutter/material.dart';

import 'transfer_form.dart';

///THIS CLASS DISPLAYS LIST OF RECEIVERS WHO CAN RECEIVE A TRANSFER
///LIST OF USERS EXCLUDING THE SENDER
class ReceiversList extends StatefulWidget {
  final sender; //receiving sender as an object from user_profile.dart
  const ReceiversList({Key? key, this.sender}) : super(key: key);
  @override
  State<ReceiversList> createState() => _ReceiversListState();
}

class _ReceiversListState extends State<ReceiversList> {
  @override
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List recievers = [];
  Future readData() async {
    //receiving data of all users
    List<Map> response = await sqlDb.readData("SELECT * FROM 'users'");
    recievers.addAll(response);
    isLoading = false;
    //excluding sender's info using the userId attribute
    for (int count = 0; count < recievers.length; count++) {
      if (recievers[count]['userId'] == widget.sender['userId']) {
        recievers.removeAt(count);
      }
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Receivers List',
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
        body: isLoading == true
            ? const CircularProgressIndicator()

            ///------------------------------List of Receivers-------------------------------
            : ListView.builder(
                itemCount: recievers.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      color: const Color.fromRGBO(230, 239, 255, 1),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransferForm(
                                    sender: widget.sender,
                                    receiver: recievers[i],
                                  )));
                        },
                        child: ListTile(
                            title: Text("${recievers[i]['name']}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //--------------------------Balance-----------------------
                                Text("${recievers[i]['currentBalance']}",
                                    style: const TextStyle(fontSize: 16)),
                                const Text("\$",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                      ),
                    ),
                  );
                },
              ));
  }
}
