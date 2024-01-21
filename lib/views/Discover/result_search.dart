import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/search_controller.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultSearch extends StatefulWidget {
   ResultSearch({super.key, required this.searchText, required this.textController});
String searchText;
TextEditingController textController;
  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2); // Вкажіть довжину вкладок
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: searchTextField(context),
        centerTitle: true,
        leadingWidth: 70.w,
        leading: Container(
          margin: EdgeInsets.only(left: 20.w),
          width: 20.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xfff6f6f6))
          ),
          child: Icon(Icons.arrow_back),
        ),
        bottom: TabBar(
          overlayColor : MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          labelColor: Color(0xffF4612D),
          indicatorColor: Color(0xffF4612D),
          unselectedLabelColor: Color(0xff797979),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          tabs: [
            Tab(text: 'Рецепти'),
            Tab(text: 'Автори'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ваші віджети для вкладок тут
        ResultSearchRecipe(searchText : widget.searchText),
         
         
       ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 12.h,),
        itemCount: users.length,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        itemBuilder: (context, index) {
          return  Row(
            children: [
              CircleAvatar(
                // Вставте зображення користувача або ініціали
                backgroundImage: NetworkImage('url_to_user_image'),
                child: Text(users[index]['name'][0]), // Ініціали користувача
                radius: 24.r,
              ),
              SizedBox(width: 12.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(users[index]['name'], style: TextStyle(color: Color(0xff242424), fontWeight: FontWeight.w500),),
                  Text('${users[index]['recipes']} Recipes', style: TextStyle(color: Color(0xff727272), fontSize: 12.sp)),
                ],
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  // Додайте логіку для підписки/відписки
                },
                style: ButtonStyle(
                  side: MaterialStatePropertyAll(BorderSide(color: Color(0xffF4612D)))
                ),
                child: Text(
                  users[index]['isFollowing'] ? 'Слідкеєте' : 'Слідкувати',
                  style: TextStyle(color: Color(0xffF4612D)),
                ),
              ),
            ],
          );         
        },
      ),
        ],
      ),
    );
  }
 final List<Map<String, dynamic>> users = [
    {'name': 'Alexander Harrison', 'recipes': 145, 'isFollowing': false},
    {'name': 'Olivia Harrison', 'recipes': 125, 'isFollowing': true},
    {'name': 'Sophia Harrison', 'recipes': 155, 'isFollowing': true},
    {'name': 'Grace Harrison', 'recipes': 145, 'isFollowing': false},
    {'name': 'Ava Harrison', 'recipes': 455, 'isFollowing': true},
    // Додайте більше користувачів, якщо потрібно
  ];



  Widget searchTextField(context){
    final SearchRecipeController searchController = Get.put(SearchRecipeController());
    return Row(
         children: [
           Expanded(
             child: Container(
              height: 45.sp,
              
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               decoration: const BoxDecoration(
                 color: Color(0xfff6f6f6),
                 borderRadius: BorderRadius.all(Radius.circular(8))
               ),
               child: Row(
               // /  mainAxisAlignment: MainAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                    Image.asset("assets/icons/search.png", width: 22.sp, height: 22.sp, color: Color(0xffF4612D),),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        //autofocus: true, // Автофокус увімкнений
                        //focusNode: textFirstFocusNode,
                        controller: widget.textController,
                         onSubmitted: (value) => searchController.fetchRecipes(value),//Navigator.push(context, MaterialPageRoute(builder: (context) => ResultSearch(searchText : value))),
                        textAlignVertical: TextAlignVertical.center,
                      //   onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                        decoration: InputDecoration(
                          
                         border: InputBorder.none,
                         hintText: 'Пошук рецептів...',
                         hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.w400)
                       ),
                      ),
                    )
                 ],
               ),
             ),
           )]
    );
  }

 
}

class ResultSearchRecipe extends StatelessWidget {
   ResultSearchRecipe({super.key, required this.searchText});
   String searchText;
final SearchRecipeController searchController = Get.find<SearchRecipeController>();
  @override
  Widget build(BuildContext context) {
    searchController.fetchRecipes(searchText);
    return   Obx(() {

    return   Skeletonizer(
  enabled: searchController.isLoading.value,
  child:
     searchController.status =="ok".obs ?  ListView.builder(
           shrinkWrap: true,
           itemCount: searchController.recipesList.length,
           itemExtent: 220.h,
           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
           itemBuilder:(context, index) => itemPopular(searchController.recipesList[index], context),
    ) : Center(child: Text("По вашому запиту нічого не знайдено"),)
       
    );
  }); 
}



   Widget itemPopular(Recipe recipe, context){
    final RecipeController controllerFavorite = Get.find<RecipeController>();
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeID: recipe.id)));
      },
      child: Container(
        width: 324.w,
        margin: EdgeInsets.only(bottom: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(image: NetworkImage(recipe.imageUrl), fit: BoxFit.cover)
        ),
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp,),
                        Text("${recipe.rating} (1k+ Відгуків)", style: TextStyle(fontSize: 12.sp),),
                      ],
                    )
                  ),
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Icon(Icons.favorite,  color: controllerFavorite.favoriteRecipes.contains(recipe.id) ? Colors.red : Color(0xffE6E6E7),size: 18.sp,)
                  )
                ],
              ),
            ),
            Align(
              alignment: const  Alignment(0, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                height: 60.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: const Color(0xffF6F6F6)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(recipe.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff2c2c2c)),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Color(0xffF4612D),size: 14.sp,),
                        SizedBox(width: 4,),
                        Text("${recipe.cookingTime} мін.", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text(recipe.difficulty, style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        //   child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        // ),
                        // Text("by Arlene McCoy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}