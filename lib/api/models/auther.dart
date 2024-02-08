class AuthorDetail {
  late String id;
  late String name;
  late String profilePhotoUrl;
  late int recipeCount;
  late String level;
  late int followers;
  late int following;
  late String about;

  AuthorDetail({
    required this.id,
    required this.name,
    required this.profilePhotoUrl,
    required this.recipeCount,
    required this.level,
    required this.followers,
    required this.following,
    required this.about,
  });
 factory AuthorDetail.empty() {
    return AuthorDetail(
      id: '',
      name: '',
      profilePhotoUrl: '',
      recipeCount: 0,
      level: '',
      followers: 0,
      following: 0,
      about: '',
    );
  }
  factory AuthorDetail.fromJson(Map<String, dynamic> json) {
    return AuthorDetail(
      id: json['id'].toString() as String,
      name: json['name'] as String,
      profilePhotoUrl: json['profile_pic'] as String,
      recipeCount: json['recipe_count'] as int,
      level: json['level'] as String,
      followers: json['followers'] as int,
      following: json['following'] as int,
      about: json['about'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePhotoUrl': profilePhotoUrl,
      'recipe_count': recipeCount,
      'level': level,
      'followers': followers,
      'following': following,
      'about': about,
    };
  }
}
