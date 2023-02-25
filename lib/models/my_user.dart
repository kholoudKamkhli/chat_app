class MyUser{
  static const String COLLECTION_NAME  = "Users";
  String id;
  String username;
  String email;
  MyUser({required this.id,required this.username,required this.email});
  MyUser.fromJson(Map<String,dynamic>json):this(
    id:json["id"],
    username:json["username"],
    email:json["email"],
  );
  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "username":username,
      "email":email,
    };
  }
}