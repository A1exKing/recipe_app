import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/api_recipe.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/views/RecipeDetail/app_bar.dart';
import 'package:food_recipe_app/views/RecipeDetail/description_text.dart';
import 'package:food_recipe_app/views/Review/review_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class RecipeDetailPage extends StatelessWidget {
   RecipeDetailPage({super.key, this.recipeID});
  String? recipeID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<RecipeDetail>(
  future: fetchDetailsRecipe(recipeID), // Функція запиту даних
  builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator()); // Показуємо індикатор завантаження
    } else if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    } else if (snapshot.hasData) {
     RecipeDetail recipe = snapshot.data!;
     return 
     CustomScrollView(
            slivers: [
              MySliverAppBar(imageUrl: recipe.imageUrl,recipe: recipe,),
              SliverToBoxAdapter(
                
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //Text("Pasta", style: TextStyle(color: Color(0xff797979), fontSize: 14.sp),),
                          const Spacer(),
                          Icon(Icons.star, color: Color(0xffFAB020),),
                          Text(recipe.rating.toString(), style: TextStyle(color: Color(0xff797979), fontSize: 14.sp),),
                        ],
                      ),
                      SizedBox(height: 12.h,),
                      Text(recipe.name, style: TextStyle(color: Color(0xff242424), fontSize: 18.sp, fontWeight: FontWeight.w500),),
                      SizedBox(height: 20.h,),
                      Text("Автор", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundImage: NetworkImage(recipe.imageUrl),
                          ),
                          SizedBox(width: 12.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${recipe.author}", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                              Text("Шеф", style: TextStyle(color: Color(0xff797979), fontSize: 14.sp),),
                            ],
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 21.r,
                            backgroundColor: Color(0xfff6f6f6),
                            child: Icon(Icons.chat, color: Color(0xfff4612d),),
                          ),
                          SizedBox(width: 12.w,),
                          CircleAvatar(
                            radius: 21.r,
                            backgroundColor: Color(0xfff6f6f6),
                            child: Icon(Icons.phone, color: Color(0xfff4612d),),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Text("Опис", style: TextStyle(color: Color(0xff242424), fontSize: 18.sp, fontWeight: FontWeight.w500),),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 6.h),
                        child:  ExpandableText(
                          text: recipe.description
                          //trimLines: 3,
                        )
                      ),
                      SizedBox(
                        height: 65,
                        
                        child: ListView(
                         scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16),
                             // width: 150.w,
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Color(0xfff6f6f6))
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 21.r,
                                    backgroundColor: Color(0xfff6f6f6),
                                    child: Icon(Icons.timer_outlined, color: Color(0xfff4612d),),
                                  ),
                                  SizedBox(width: 8.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Час приготування", style: TextStyle(color: Color(0xff797979), fontSize: 12.sp)),
                                      Text(recipe.cookingTime.toString(), style: TextStyle(color: Color(0xfff4612d), fontSize: 14.sp)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                             // width: 150.w,
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Color(0xfff6f6f6))
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 21.r,
                                    backgroundColor: Color(0xfff6f6f6),
                                    child: Icon(Icons.timer_outlined, color: Color(0xfff4612d),),
                                  ),
                                  SizedBox(width: 8.w,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Час приготування", style: TextStyle(color: Color(0xff797979), fontSize: 12.sp)),
                                      Text("35 min", style: TextStyle(color: Color(0xfff4612d), fontSize: 14.sp)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 12.h),
                        child: const Divider(color: Color(0xfff6f6f6),),
                      ),
                      
                      

                      Row(
                        children: [
                          Icon(Icons.fastfood, color: Color(0xfff4612d),),
                          SizedBox(width: 8.w,),
                          Text("Інгредієнти", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(top: 8.h),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipe.ingridients.length,
                        itemBuilder:(context, index) {
                          return Row(
                            children: [
                              Icon(Icons.circle, color: Color(0xfff6f6f6), size: 8,),
                              SizedBox(width: 4.w,),
                              Text("${recipe.ingridients[index]}", style: TextStyle(color: Color(0xff242424), fontSize: 14.sp,),),
                            ],
                          );
                        },
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text("Детальний план приготування", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      ),
                  recipe.plan != null ?  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
        children: parseRecipeText(recipe.plan!),
      ) : Container(),
       Padding(
                        padding: const EdgeInsets.only( bottom: 16),
                        child: Text("Перегляути відео", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      ),
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: YoutubeVideoScreen()),

                       ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                    }, child: Text("Відгуки")),
                    
                    ],
                  ),
                ),
              )
            ],
          );} else {
      return Text('Не знайдено жодного рецепту.');
    }
        }
      )
    
    );
  }
}


List<Widget> parseRecipeText(String recipeText) {
  RegExp regExp = RegExp(r"\[img: (.*?)\]");
  List<Widget> recipeParts = [];
  int lastMatchEnd = 0;

  for (var match in regExp.allMatches(recipeText)) {
    final textBeforeImage = recipeText.substring(lastMatchEnd, match.start);
    final imageUrl = match.group(1)!;
    lastMatchEnd = match.end;

    // Додаємо текст перед зображенням
    if (textBeforeImage.isNotEmpty) {
      recipeParts.add(Text(textBeforeImage));
    }

    // Додаємо зображення
    recipeParts.add(Image
.network(imageUrl));
}

// Додаємо останній шматок тексту після останнього зображення
final textAfterLastImage = recipeText.substring(lastMatchEnd);
if (textAfterLastImage.isNotEmpty) {
recipeParts.add(Text(textAfterLastImage));
}

return recipeParts;
}




class YoutubeVideoScreen extends StatefulWidget {
  @override
  _YoutubeVideoScreenState createState() => _YoutubeVideoScreenState();
}

class _YoutubeVideoScreenState extends State<YoutubeVideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'qJG8xgQYBwg', // ID відео з YouTube
      flags: YoutubePlayerFlags(
        autoPlay: false ,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
       YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          _controller.addListener(() {});
        },
      );
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
