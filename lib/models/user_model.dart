
class UserModel{
  String ? firstName;
  String ? lastName;
  String ? phone;
  String ? address;
  String ? dateOfBirth;
  String ? image ;
  String ? bio;


  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    this.image,
    this.bio,

  });

  UserModel.fromJson(Map<String, dynamic> json){
    firstName = json ['firstName'];
    lastName = json ['lastName'];
    phone = json ['phone'];
    address = json ['address'];
    image = json ['image'];
    dateOfBirth= json['dateOfBirth'];
    bio =json['bio'];
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName':firstName,
      'lastName':lastName,
      'phone':phone,
      'address':address,
      'image':image,
      'dateOfBirth':dateOfBirth,
      'bio':bio,
    };
  }
}