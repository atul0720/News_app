// for sending and receiving data from cloud fire store  we use  Models
class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;


  //  for sending and receiving data from registration screen
 UserModel({this.uid,this.email,this.firstName,this.secondName});

 // receiving  data from server(create map with data)
factory UserModel.fromMap(map)
{
  return UserModel(
    uid: map['uid'],
    email: map['email'],
    firstName: map['firstName'],
    secondName: map['secondName'],
  );
}

// for sending data to server
Map<String,dynamic> toMap() {
  return {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'secondName': secondName,
  };

}

}
