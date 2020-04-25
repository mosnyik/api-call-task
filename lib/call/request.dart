
class Users{
  String name;
  String email;
  String username;
  String phone;

  Users({this.name, this.email, this.username, this.phone});

  //converting the json strings received to map of objects
  Users.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
  }
}