import 'package:flutter/material.dart';

import 'sqldb.dart';

///USING THIS CLASS TO INSERT USERS DATA INTO THE DATABASE
class DataEntry extends StatefulWidget {
  const DataEntry({Key? key}) : super(key: key);

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(
        child: Column(
          children: [
            //--------------------------------INSERT BUTTON-----------------------------------
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response = await sqlDb.insertData(
                      "INSERT INTO users(name,email,currentBalance,phone) VALUES ('Max Neil','Max@mail.com','1030','456876332') ");
                  print(
                      response); //prints 0 on fail or the number of row inserted on success
                },
                child: Text('Insert Data'),
              ),
            ),
            //--------------------------------READ BUTTON-----------------------------------
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  List<Map> response =
                      await sqlDb.readData("SELECT * FROM 'users' ");
                  print("$response"); //print All users in database
                },
                child: Text('Read Data'),
              ),
            ),
            //--------------------------------DELETE BUTTON-----------------------------------
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response = await sqlDb
                      .deleteData("DELETE FROM 'users' WHERE userId = 8");
                  print(
                      "$response"); //prints 0 on fail and other integer on success
                },
                child: Text('Delete Data'),
              ),
            ),
            //--------------------------------UPDATE BUTTON-----------------------------------
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  //return 0 on fail and any other integer on success
                  int response = await sqlDb.updateData(
                      "UPDATE 'users' SET 'phone' = '94835462' WHERE userId = 5");
                  print(
                      "$response"); //prints 0 on fail and other integer on success
                },
                child: Text('Update Data'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
