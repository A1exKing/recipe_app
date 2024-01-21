import 'dart:convert';


class User {
 late String userName;
 late String email;
 late String photo;
  late String? backProfilePhoto;
  User({
    required this.userName,
    required this.email,
    required this.photo,
     this.backProfilePhoto,
  });
    

  User copyWith({
    String? userName,
    String? email,
    String? photo,
    String? backProfilePhoto,
  }) {
    return User(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      backProfilePhoto: backProfilePhoto ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'photo': photo,
      'backProfilePhoto': backProfilePhoto,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['username'] as String,
      email: map['email'] as String,
      photo: map['profile_photo'] as String,
      backProfilePhoto: map['back_profile_photo']  as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(userName: $userName, email: $email, photo: $photo)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName &&
      other.email == email &&
      other.photo == photo;
  }

  @override
  int get hashCode => userName.hashCode ^ email.hashCode ^ photo.hashCode;
}
