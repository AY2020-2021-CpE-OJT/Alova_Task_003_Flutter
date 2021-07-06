import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactModel{
  final String firstname;
  final String lastname;
  final String phoneNumber;

  ContactModel(this.firstname, this.lastname, this.phoneNumber);

}

class PostContact extends StatefulWidget{
  @override
  _PostContactState createState() => _PostContactState();
}

class _PostContactState extends State<PostContact>{

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<ContactModel> saveData = <ContactModel>[];

  void saveContact(){
    setState(() {
      saveData.insert(
        0,
        ContactModel(
            firstnameController.text,
            lastnameController.text,
            phoneNumberController.text));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Contact"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter first name"),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter last name"),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter phone number"),
            ),
            SizedBox(height: 10.0,),
            new SizedBox(
              width: 300.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: (){
                    saveContact();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostTheContact(todo: saveData)), (_) => false);
                  },
                  child: new Text(
                      "Submit",
                      style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(
                context,
                'Activity_two', (_) => false);
          },
          label: Text("Go to Contacts"),
          elevation: 7.0,),
    );
  }

}
class PostTheContact extends StatelessWidget{
  final List<ContactModel> todo;
  const PostTheContact({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response>createAlbum(String firstname, String lastname, String phoneNumber){
      return http.post(
          Uri.http('192.168.1.4:3000', 'phoneBook'),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode({
          'firstname': firstname,
          'lastname': lastname,
          'phoneNumber': phoneNumber
        }),
      );
    }
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contact has been added'),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index){
                  createAlbum(
                      todo[index].firstname,
                      todo[index].lastname,
                      todo[index].phoneNumber);
                  return Container(
                    child: Column(
                      children: <Widget>[
                        AlertDialog(
                          title: Text("Success!"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("You have added a contact.")
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: (){
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'Activity_two', (_) => false);
                                },
                                child: Text("Check Contacts")),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'Activity_one', (_) => false);
                                }, child: Text("Add Again"))
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
        onWillPop: () async => false,);

  }
}