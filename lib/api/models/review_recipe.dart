// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class ReviewRecipe {
 final String nameUser;
 final String photoUser;
 final String textReview;
 final double rating;
  ReviewRecipe({
    required this.nameUser,
    required this.photoUser,
    required this.textReview,
    required this.rating,
  });


  ReviewRecipe copyWith({
    String? nameUser,
    String? photoUser,
    String? textReview,
    double? rating,
  }) {
    return ReviewRecipe(
      nameUser: nameUser ?? this.nameUser,
      photoUser: photoUser ?? this.photoUser,
      textReview: textReview ?? this.textReview,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameUser': nameUser,
      'photoUser': photoUser,
      'textReview': textReview,
      'rating': rating,
    };
  }

  factory ReviewRecipe.fromMap(Map<String, dynamic> map) {
    return ReviewRecipe(
      nameUser: map['name'] as String,
      photoUser: map['profile_pic'] as String,
      textReview: map['text'] as String,
      rating: map['rating'].toDouble()
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewRecipe.fromJson(String source) => ReviewRecipe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewRecipe(nameUser: $nameUser, photoUser: $photoUser, textReview: $textReview, rating: $rating)';
  }

  @override
  bool operator ==(covariant ReviewRecipe other) {
    if (identical(this, other)) return true;
  
    return 
      other.nameUser == nameUser &&
      other.photoUser == photoUser &&
      other.textReview == textReview &&
      other.rating == rating;
  }

  @override
  int get hashCode {
    return nameUser.hashCode ^
      photoUser.hashCode ^
      textReview.hashCode ^
      rating.hashCode;
  }
}
