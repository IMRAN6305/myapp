class UserModel{

  String userName;
  String email;
  String gender;
  String phoneNumber;
  String password;

  UserModel({
    required this.userName,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.password
  });

  factory UserModel.fromDoc(Map<String,dynamic> doc){
    return UserModel(userName: doc['userName'],
        email: doc['email'],
        gender: doc['gender'],
        phoneNumber: doc['phoneNumber'], password: doc['password']);
  }

  Map<String,dynamic> toDoc(){
    return {
      'userName': userName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'password': password
    };
  }

}



