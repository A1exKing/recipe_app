import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text("Leave Review"),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
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
                Padding(
                  padding:  EdgeInsets.only(top: 20.h),
                  child: const Divider(color: Color(0xfff6f6f6),),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 40.w ,vertical: 20.h),
                  child: Text("How Would You Rate This Recipe?",textAlign: TextAlign.center, style: TextStyle(fontSize: 24.sp, color: Color(0xff242424), fontWeight: FontWeight.w500),),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: 8.h),
                  child: const Divider(color: Color(0xfff6f6f6),),
                ),
                Center(child: Text("Your overall rating", style: TextStyle(fontSize: 14.sp, color: Color(0xff797979)),)),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.h),
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Color(0xfff6f6f6),
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
                   Padding(
                  padding:  EdgeInsets.only(bottom: 12.h),
                  child: const Divider(color: Color(0xfff6f6f6),),
                ),
                Text("Add detailed review", style: TextStyle(fontSize: 14.sp, color: Color(0xff242424), fontWeight: FontWeight.w500),),
                 SizedBox(height: 12.h,),
                Container(
                  height: 180.h,
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color(0xfff6f6f6)
                  ),
                  child: TextField(
                    maxLines: null, // робить кількість рядків необмеженою
                    keyboardType: TextInputType.multiline, // забезпечує можливість переходу на новий рядок
                    decoration: InputDecoration(
                      hintText: 'Enter here...',
                      hintStyle: TextStyle(color: Color(0xff797979)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14,),
                Row(
                  children: [
                    Image.asset("assets/icons/add-photo.png", width: 24.w, color: Color(0xffF4612D),),
                    SizedBox(width: 8,),
                    Text("add photo", style: TextStyle(fontSize: 14.sp, color: Color(0xffF4612D), fontWeight: FontWeight.w500),),
                  ],
                ),
                
              ],
            ),
          ),
           Align(
            alignment: Alignment(0,1),
            child: Container(
              height: 74.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0xfff6f6f6), offset: Offset(0, 2), blurRadius: 8, spreadRadius: 4)
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReviewPage()));
                                    },
                                    style: ButtonStyle(
                      //textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStatePropertyAll(Color(0xfff6f6f6))
                                    ),
                                    child: Text("Cancel",style: TextStyle(color: Color(0xffF4612D), fontSize: 16.sp, fontWeight: FontWeight.w500)),
                                  ),
                    ),
                  ),
              SizedBox(width: 12,),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReviewPage()));
                        },
                        style: ButtonStyle(
                          //textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                          backgroundColor: MaterialStatePropertyAll(Color(0xffF4612D))
                        ),
                        child: Text("Submite",style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}