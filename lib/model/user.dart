

class User {
  final int uid;
  final String uname;
  final int uage;
  final String uemail;
  final String uaddress;
  final String upwd;

  User({this.uid, this.uname, this.uage, this.uemail , this.uaddress, this.upwd});


  factory User.FromJson(Map<String, dynamic> json){
    return User(
      uid: json['uid'],
      uname: json['uname'],
      uage: json['uage'],
      uemail: json['uemail'],
      uaddress: json['uaddress'],
      upwd: json['upwd']
    );
  }


  Map<String,dynamic> ToJson() => {
    'uid':uid,
    'uname':uname,
    'uage':uage,
    'uemail':uemail,
    'uaddress':uaddress,
    'upwd':upwd
  };


}