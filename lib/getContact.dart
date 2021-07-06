import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class User {
  final String firstname, lastname, phoneNumber;

  User(this.firstname, this.lastname, this.phoneNumber);
}


class GetContact extends StatefulWidget {
  @override
  _GetContactState createState() => new _GetContactState();
}

class _GetContactState extends State<GetContact> {
  Future getPhoneBook() async {
    var response = await http.get(Uri.http('192.168.1.4:3000', 'phoneBook'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u['firstname'], u['lastname'], u['phoneNumber']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Sample Phonebook'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'Activity_one', (_) => false);
            },
          )),
      body: Container(
        child: Card(
            child: FutureBuilder(
          future: getPhoneBook(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(
                        snapshot.data[i].lastname,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(snapshot.data[i].firstname),
                      trailing: Text(snapshot.data[i].phoneNumber),
                    );
                  });
          },
        )),
      ),
    );
  }
}

