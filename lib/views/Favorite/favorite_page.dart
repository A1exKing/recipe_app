import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/favorite_controller.dart';
import 'package:food_recipe_app/views/Home/top_chefs.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2); // Вкажіть довжину вкладок
  }
  @override
  
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
            Tab(text: 'Recipes'),
            Tab(text: 'Chefs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ваші віджети для вкладок тут
        FavoriteRecipe(),
         
          GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 24.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Кількість стовпців
          crossAxisSpacing: 8.w, // Відстань між стовпцями
          mainAxisSpacing: 18.h, // Відстань між рядами
          childAspectRatio: 0.8, // Співвідношення сторін для дочірніх елементів
        ),
        itemCount: chefs.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  // Використовуйте 'AssetImage' для завантаження зображень з активів
                  // Або 'NetworkImage' для завантаження з мережі
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(chefs[index].image), // Приклад використання зображення з активів
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(chefs[index].name, style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xff242424)),),
            ],
          );
        },
      ),
    
        ],
      ),
    );
  }
final  chefs = [
    TopChef(name : "Esther T.", image: "https://images.unsplash.com/photo-1512485800893-b08ec1ea59b1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jenny M.", image: "https://images.unsplash.com/photo-1577219491135-ce391730fb2c?q=80&w=1954&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name : "Jacob U.", image: "https://images.unsplash.com/photo-1611657365907-1ca5d9799f59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  TopChef(name: "Bessi K.", image: "https://images.unsplash.com/photo-1581299894007-aaa50297cf16?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    // Додайте більше шеф-кухарів, якщо потрібно
  ];
  Widget searchTextField(context){
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
                       
                        textAlignVertical: TextAlignVertical.center,
                        onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                       // onSubmitted: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => ResultSearch())),
                        decoration: InputDecoration(
                        
                         border: InputBorder.none,
                         hintText: 'Search Any Recipe...',
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


class FavoriteRecipe extends StatelessWidget {
   FavoriteRecipe({super.key});
  
final FavoriteController favoriteController = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    favoriteController.fetchFavoriteList("26");
    return   Obx(() {

    return   Skeletonizer(
  enabled: favoriteController.isLoading.value,
  child:
     favoriteController.status =="ok".obs ?  ListView.builder(
           shrinkWrap: true,
           itemCount: favoriteController.recipesList.length,
           itemExtent: 220.h,
           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
           itemBuilder:(context, index) => itemPopular(favoriteController.recipesList[index], context),
    ) : Center(child: Text("По вашому запиту нічого не знайдено"),)
       
    );
  }); 
}



   Widget itemPopular(Recipe recipe, context){
      final RecipeController controllerFavorite = Get.find<RecipeController>();
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeID: recipe.id,)));
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
                        Text("${recipe.rating} (1k+ Reviews)", style: TextStyle(fontSize: 12.sp),),
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
                    child: Icon( Icons.favorite, color: controllerFavorite.favoriteRecipes.contains(recipe.id) ? Colors.red : Color(0xffE6E6E7),size: 18.sp,)
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
                        Text("${recipe.cookingTime} min", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text(recipe.difficulty, style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                        ),
                        Text("by Arlene McCoy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
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