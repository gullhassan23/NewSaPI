// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:news_api/Constants/AppColors.dart';
// import 'package:news_api/Models/CategoriesNewsModel.dart';
// import 'package:news_api/Repository/ViewModel.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   final format = DateFormat("MMM dd, yyyy");
//   String categoryname = "general";

//   List<String> categoryList = [
//     'General',
//     'Business',
//     'Entertainment',
//     'Sports',
//     'Health',
//     'Technology'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final width = 1.sw; // screen width
//     final height = 1.sh;
//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: Colors.white,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.h),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50.h,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categoryList.length,
//                   itemBuilder: (ctx, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         categoryname = categoryList[index];
//                         setState(() {});
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 12.w),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.r),
//                               color: categoryname == categoryList[index]
//                                   ? AppColors.Selectbtn
//                                   : AppColors.UnSelectbtn),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 12.h),
//                             child: Center(
//                               child: Text(
//                                 categoryList[index].toString(),
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13, color: AppColors.data),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Expanded(
//               child: FutureBuilder<CategoriesNewsModel>(
//                 future: NewsViewModelRepository().fetchCategories(categoryname),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: SpinKitHourGlass(
//                           size: 60.w, color: Colors.black), // ScreenUtil size
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         'Error: ${snapshot.error}',
//                         style:
//                             TextStyle(fontSize: 18.sp), // ScreenUtil font size
//                       ),
//                     );
//                   } else if (!snapshot.hasData ||
//                       snapshot.data!.articles!.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No news available',
//                         style:
//                             TextStyle(fontSize: 18.sp), // ScreenUtil font size
//                       ),
//                     );
//                   } else {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data!.articles!.length,
//                       itemBuilder: (context, index) {
//                         DateTime dateTime = DateTime.parse(snapshot
//                             .data!.articles![index].publishedAt
//                             .toString());
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 15.h),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(15.r),
//                                 child: CachedNetworkImage(
//                                   imageUrl: snapshot
//                                       .data!.articles![index].urlToImage
//                                       .toString(),
//                                   fit: BoxFit.cover,
//                                   height: height * .18.h,
//                                   width: width * .3.w,
//                                   placeholder: (ctx, url) => Container(
//                                     child: SpinKitHourGlass(
//                                         size: 60.w,
//                                         color: Colors.white), // ScreenUtil size
//                                   ),
//                                   errorWidget: (ctx, url, err) => Icon(
//                                     Icons.error_outline_outlined,
//                                     color: Colors.red,
//                                     size: 60.w, // ScreenUtil size
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: Container(
//                                 padding: EdgeInsets.only(left: 15.w),
//                                 height: height * .18.h,
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(2),
//                                       child: Text(
//                                         snapshot.data!.articles![index].title
//                                             .toString(),
//                                         maxLines: 3,
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 15.sp,
//                                             color: AppColors.data,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             snapshot.data!.articles![index]
//                                                 .source!.name
//                                                 .toString(),
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 13,
//                                                 color: AppColors.Selectbtn,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                         Text(
//                                           format.format(dateTime),
//                                           maxLines: 3,
//                                           style: GoogleFonts.poppins(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w500),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ))
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/Constants/AppColors.dart';
import 'package:news_api/Providers/NewsProvider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final format = DateFormat("MMM dd, yyyy");
  String categoryname = "general";

  List<String> categoryList = [
    'General',
    'Business',
    'Entertainment',
    'Sports',
    'Health',
    'Technology'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false)
          .fetchCategories(categoryname);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = 1.sw; // screen width
    final height = 1.sh;
    final categoryNewsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        categoryname = categoryList[index];
                        categoryNewsProvider.fetchCategories(categoryname);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: categoryname == categoryList[index]
                                  ? AppColors.Selectbtn
                                  : AppColors.UnSelectbtn),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Center(
                              child: Text(
                                categoryList[index].toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: AppColors.data),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: categoryNewsProvider.isLoading
                  ? Center(
                      child: SpinKitHourGlass(
                          size: 60.w, color: Colors.black), // ScreenUtil size
                    )
                  : categoryNewsProvider.error.isNotEmpty
                      ? Center(
                          child: Text(
                            'Error: ${categoryNewsProvider.error}',
                            style: TextStyle(
                                fontSize: 18.sp), // ScreenUtil font size
                          ),
                        )
                      : categoryNewsProvider.categoriesNews == null ||
                              categoryNewsProvider
                                  .categoriesNews!.articles!.isEmpty
                          ? Center(
                              child: Text(
                                'No news available',
                                style: TextStyle(
                                    fontSize: 18.sp), // ScreenUtil font size
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: categoryNewsProvider
                                  .categoriesNews!.articles!.length,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateTime.parse(
                                    categoryNewsProvider.categoriesNews!
                                        .articles![index].publishedAt
                                        .toString());
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15.h),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: CachedNetworkImage(
                                          imageUrl: categoryNewsProvider
                                              .categoriesNews!
                                              .articles![index]
                                              .urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * .18.h,
                                          width: width * .3.w,
                                          placeholder: (ctx, url) => Container(
                                            child: SpinKitHourGlass(
                                                size: 60.w,
                                                color: Colors
                                                    .white), // ScreenUtil size
                                          ),
                                          errorWidget: (ctx, url, err) => Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.red,
                                            size: 60.w, // ScreenUtil size
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.only(left: 15.w),
                                        height: height * .18.h,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(
                                                categoryNewsProvider
                                                    .categoriesNews!
                                                    .articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 3,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15.sp,
                                                    color: AppColors.data,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    categoryNewsProvider
                                                        .categoriesNews!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        color:
                                                            AppColors.Selectbtn,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 3,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
