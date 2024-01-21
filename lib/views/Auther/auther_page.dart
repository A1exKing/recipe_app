import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/api/models/recipe.dart';
import 'package:food_recipe_app/controllers/auther_contoroller.dart';
import 'package:food_recipe_app/views/Auther/app_bar_sliver.dart';
import 'package:food_recipe_app/views/RecipeDetail/recipe_detail_page.dart';
import 'package:get/get.dart';

class AutherPage extends StatefulWidget {
  final AutherController autherController = Get.put(AutherController());
  final RecipeController recipeController = Get.put(RecipeController());
  AutherPage({super.key});

  @override
  State<AutherPage> createState() => _AutherPageState();
}

final ScrollController scrollSliverController = ScrollController();

class AvatarController extends GetxController {
  var avatarSize = 1.0.obs; // Початковий розмір CircleAvatar

  void updateSize(double scrollPosition) {
    // Оновлення розміру в залежності від позиції прокрутки
    avatarSize.value = scrollPosition /* Ваша логіка для зміни розміру */;
  }
}

class _AutherPageState extends State<AutherPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    var avatarController = Get.put(AvatarController());
    scrollSliverController.addListener(() {
      // Отримайте контролер GetX
      double appBarHeight =
          420; // Визначте максимальну висоту вашого SliverAppBar тут;
      double shrinkOffset = scrollSliverController.position.pixels;
      bool isAppBarCollapsed = shrinkOffset > appBarHeight;
      // Оновіть розмір CircleAvatar в залежності від позиції прокрутки
      shrinkOffset < 240
          ? avatarController.updateSize(shrinkOffset * 0.01)
          : null;
      print(avatarController.avatarSize);
    });

    // Вкажіть довжину вкладок
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
   widget.autherController.fetchAuthors("1");
    widget.recipeController.fetchRecipesAuthor("1");
});
   
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (widget.autherController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            print(widget.autherController.status);

            return widget.autherController.status == "ok".obs
                ? NestedScrollView(
                    controller: scrollSliverController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        AutherSliverAppBar(
                            author: widget.autherController.authorsList[0]),
                             SliverTabBar(),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        // Ваші віджети для вкладок тут
                        ListView.builder(
                          itemCount: widget.recipeController.recipes.length,
                          itemExtent: 220
                              .h, // Переконайтеся, що у вас є доступ до цих значень у вашому контексті
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 18.h),
                          itemBuilder: (context, index) =>
                              itemPopular( widget.recipeController.recipes[index],context),
                        ),
                        SingleChildScrollView(
                          // Використовуйте SingleChildScrollView для інших вкладок, якщо вони не містять ListView
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 14.h),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text("About",
                                    style: TextStyle(
                                        color: Color(0xff242424),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
// Інший вміст для цієї вкладки
                              ],
                            ),
                          ),
                        ),
                        Text("data"), // Приклад інших вкладок
                        Text("data"),
                      ],
                    ),
                  )
                : Center(
                    child: Text("List is Empty"),
                  );
          }
        }));
  }

  Widget itemPopular(Recipe recipe,context) {
    final RecipeController controllerFavorite = Get.find<RecipeController>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RecipeDetailPage(recipeID: recipe.id,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        width: 324.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
                image: NetworkImage(
                    recipe.imageUrl),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.sp,
                            ),
                            Text(
                              "${recipe.rating} (1k+ Reviews)",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        )),
                    Center(
                      child: Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.favorite,
                            color:  controllerFavorite.favoriteRecipes.contains(recipe.id) ? Colors.red : Color(0xffE6E6E7),
                            size: 18.sp,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                height: 60.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: const Color(0xffF6F6F6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          recipe.name,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff2c2c2c)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Color(0xffF4612D),
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${recipe.cookingTime} min",
                          style: TextStyle(
                              fontSize: 12.sp, color: Color(0xff7A7A7A)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(
                            Icons.circle,
                            color: Color(0xff7A7A7A),
                            size: 5.sp,
                          ),
                        ),
                        Text(
                          "Easy",
                          style: TextStyle(
                              fontSize: 12.sp, color: Color(0xff7A7A7A)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(
                            Icons.circle,
                            color: Color(0xff7A7A7A),
                            size: 5.sp,
                          ),
                        ),
                        Text(
                          "by Arlene McCoy",
                          style: TextStyle(
                              fontSize: 12.sp, color: Color(0xff7A7A7A)),
                        ),
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

class SliverTabBar extends StatelessWidget {
  const SliverTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: _tabController,
          labelColor: Color(0xffF4612D),
          indicatorColor: Color(0xffF4612D),
          unselectedLabelColor: Color(0xff797979),
          tabs: [
            Tab(text: 'Recipes'),
            Tab(text: 'About'),
            Tab(text: 'Gallery'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      pinned: true,
    );
  }
}
//'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE3fHx8ZW58MHx8fHx8',

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Встановіть потрібний колір фону
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

late TabController _tabController;
