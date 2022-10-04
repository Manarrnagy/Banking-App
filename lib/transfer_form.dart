import 'package:banking_app/sqldb.dart';
import 'package:banking_app/users_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///HAS A FROM THAT RECIEVES TRANSFER VALUE FROM USER
class TransferForm extends StatefulWidget {
  final sender;
  final receiver;
  const TransferForm({Key? key, this.sender, this.receiver}) : super(key: key);
  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  SqlDb sqlDb = SqlDb();
  String transferValue = "";
  bool isLoading = true;
  double senderOldBalance = 0.0;
  double receiverOldBalance = 0.0;
  bool flag = false;
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer',
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
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(230, 239, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          //--------------------------FORM-------------------------------
          child: ListView(
            children: [
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${widget.sender['name']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            const Icon(
                              Icons.arrow_right_alt_rounded,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                            Text("${widget.receiver['name']}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ]),
                      TextFormField(
                        controller: value,
                        decoration: const InputDecoration(
                          hintText: 'Enter Transfer value',
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 20,
              ),
              //-----------------------------TRANSFER BUTTON---------------------------------
              ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus!
                        .unfocus(); //closes keyboard when button is pressed
                    ///Updating Users Current Balance
                    if (widget.sender['currentBalance'] >=
                        double.parse(value.text)) {
                      double senderNewBalance =
                          widget.sender['currentBalance'] -
                              double.parse(value.text);
                      double recieverNewBalance =
                          widget.receiver['currentBalance'] +
                              double.parse(value.text);

                      int response = await sqlDb.updateData(
                          'UPDATE "users" SET "currentBalance" = "${senderNewBalance}" WHERE userId =${widget.sender['userId']}'); //subtracts from senders balance
                      int responseTwo = await sqlDb.updateData(
                          'UPDATE "users" SET "currentBalance" = "${recieverNewBalance}" WHERE userId =${widget.receiver['userId']}'); // Adds to recievers balance
                      int responseThree = await sqlDb.insertData(
                          "INSERT INTO transfers(transferValue,senderName,senderId,receiverName,receiverId) VALUES ('${double.parse(value.text)}','${widget.sender['name']}','${widget.sender['userId']}','${widget.receiver['name']}','${widget.receiver['userId']}') ");

                      if (response > 0 &&
                          responseTwo > 0 &&
                          responseThree > 0) {
                        showDialog<void>(
                          // show a card that the transfer was successful
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 2), () {
                              //navigates to user list page
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const UsersList()),
                                  (route) => false);
                            });
                            return Center(
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.greenAccent,
                                      ),
                                      Text("Transfered Succesfully"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please Enter Valid Balance')));
                      // Text(
                      //   "Please Enter Valid Balance",
                      //   style: TextStyle(color: Colors.red, fontSize: 20),
                      // );
                    }
                  },
                  child: const Text("Transfer"),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(50, 81, 180, 1),
                      elevation: 5)),
              const Text(
                //warning message
                "Note: you cannot enter a balance that is higher than the balance available in the account",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
