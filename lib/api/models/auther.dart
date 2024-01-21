class AuthorDetail {
  final String id;
  final String name;
  final String profilePhotoUrl;
  final int recipeCount;
  final String level;
  final int followers;
  final int following;
  final String about;

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
