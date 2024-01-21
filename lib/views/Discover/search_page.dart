import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe_app/views/Discover/result_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   late FocusNode textFirstFocusNode;

  @override
  void initState() {
    super.initState();
    // Створюємо FocusNode
    textFirstFocusNode = FocusNode();
  }
   @override
  void dispose() {
    // Не забудьте звільнити ресурси FocusNode
    textFirstFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title:searchTextField(context),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Популярні рецепти", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
            ...List.generate(4, (index) => Padding(
              padding:  EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  Text("Trufile Tango", style: TextStyle(color: Color(0xff797979), fontSize: 14.sp, ),),
                  const Spacer(),
                  Icon(Icons.close, color: Color.fromARGB(255, 63, 33, 33),)
                ],
              ),
            )),
            Padding(
              padding:  EdgeInsets.only(top: 24.h, bottom: 12.h),
              child: Text("Останні перегляди", style: TextStyle(color: Color(0xff242424), fontSize: 16.sp, fontWeight: FontWeight.w500),),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder:(context, index) => Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: Image.network("https://images.unsplash.com/photo-1602253057119-44d745d9b860?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGlzaHxlbnwwfHwwfHx8MA%3D%3D", fit: BoxFit.fitWidth,)
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Burst Tomato Pasta", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xff242424)),),
                           Row(
                          children: [
                            Icon(Icons.timer, color: Color(0xffF4612D),size: 14.sp,),
                            SizedBox(width: 4,),
                            Text("35 min", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                            ),
                            Text("Easy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Icon(Icons.circle, color: Color(0xff7A7A7A), size: 5.sp,),
                            ),
                            Text("by Arlene McCoy", style: TextStyle(fontSize: 12.sp, color: Color(0xff7A7A7A)),),
                          ],
                        )
                        ],
                      )),
                  ],
                ), 
              separatorBuilder:(context, index) => Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.h),
                child: const Divider(color: Color(0xfff6f6f6)),
              ), 
              itemCount: 4)
          ],
        ),
      ),
    );
  }
TextEditingController sharedController = TextEditingController();
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
                        autofocus: true, // Автофокус увімкнений
                        focusNode: textFirstFocusNode,
                        controller: sharedController,
                        textAlignVertical: TextAlignVertical.center,
                        onTapOutside: (v)=> FocusScope.of(context).requestFocus(FocusNode()),
                        onSubmitted: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => ResultSearch(searchText : value, textController : sharedController))),
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