import 'package:apicall/pages/choose_user.dart';
import 'package:flutter/material.dart';
import 'package:apicall/call/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future <List<Users>> fetchNames() async {
    var response = await http.get('https://jsonplaceholder.typicode.com/users');
    var names = List<Users>();
    print(names);

    if (response.statusCode == 200){
      var namesJson = json.decode(response.body);
      for (var name in namesJson){
        names.add(Users.fromJson(name));
      }
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Choose a User'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchNames(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => ChooseUser(snapshot.data[index]))
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://ui-avatars.com/api/?name=' +
                                      snapshot.data[index].name
                              ),
                            ),
                            title: Text(
                                snapshot.data[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data[index].email,
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  },
              );
            }else return (
            Center(child: CircularProgressIndicator(),)
            );
          },
        ) ,
      ),
    );
  }
}
