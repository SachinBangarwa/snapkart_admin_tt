class UserModel{
  String name;
  String password;

  UserModel(this.name,this.password);

  Map<String,dynamic> toJson(){
    return{
      'username':name,
      'password':password,
    };
  }

}