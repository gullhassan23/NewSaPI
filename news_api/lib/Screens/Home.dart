import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/Constants/AppColors.dart';

import 'package:news_api/Providers/NewsProvider.dart';

import 'package:news_api/Screens/categoryScreen.dart';
import 'package:provider/provider.dart';

class HOME extends StatefulWidget {
  const HOME({super.key});

  @override
  State<HOME> createState() => _HOMEState();
}

enum filterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HOMEState extends State<HOME> {
  filterList? selectedMenu;
  final format = DateFormat("MMM dd, yyyy");
  String name = "bbc-news";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNewsData(name);
      Provider.of<NewsProvider>(context, listen: false)
          .fetchCategories('general');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = 1.sw; // screen width
    final height = 1.sh; // screen height
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => CategoryScreen()));
          },
          icon: Icon(Icons.newspaper),
          color: AppColors.data,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<filterList>(
              onSelected: (filterList item) {
                if (filterList.bbcNews == item) {
                  name = "bbc-news";
                } else if (filterList.aryNews == item) {
                  name = "ary-news";
                } else if (filterList.alJazeera == item) {
                  name = "al-jazeera-english";
                } else if (filterList.cnn == item) {
                  name = "cnn-news";
                } else if (filterList.independent == item) {
                  name = "independent";
                } else if (filterList.reuters == item) {
                  name = "reuters";
                }
                setState(() {
                  selectedMenu = item;
                  newsProvider.fetchNewsData(name);
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (ctx) => <PopupMenuEntry<filterList>>[
                    PopupMenuItem<filterList>(
                        value: filterList.bbcNews, child: Text("BBC News")),
                    PopupMenuItem<filterList>(
                        value: filterList.aryNews, child: Text("ARY News")),
                    PopupMenuItem<filterList>(
                        value: filterList.alJazeera, child: Text("Al Jazeera")),
                    PopupMenuItem<filterList>(
                        value: filterList.cnn, child: Text("CNN News")),
                    PopupMenuItem<filterList>(
                        value: filterList.independent,
                        child: Text("Independent News")),
                    PopupMenuItem<filterList>(
                        value: filterList.reuters, child: Text("Reuters"))
                  ])
        ],
        title: Text(
          "News",
          style: GoogleFonts.poppins(
            color: AppColors.data,
            fontSize: 24.sp, // ScreenUtil font size
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: newsProvider.isLoading
                ? Center(
                    child: SpinKitHourGlass(
                        size: 60.w, color: Colors.white), // ScreenUtil size
                  )
                : newsProvider.error.isNotEmpty
                    ? Center(
                        child: Text(
                          'Error: ${newsProvider.error}',
                          style: TextStyle(
                              fontSize: 18.sp), // ScreenUtil font size
                        ),
                      )
                    : newsProvider.newsHeadlines == null ||
                            newsProvider.newsHeadlines!.articles!.isEmpty
                        ? Center(
                            child: Text(
                              'No news available',
                              style: TextStyle(
                                  fontSize: 18.sp), // ScreenUtil font size
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                newsProvider.newsHeadlines!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(newsProvider
                                  .newsHeadlines!.articles![index].publishedAt
                                  .toString());
                              return SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.55,
                                      width: width * 0.9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.4.w),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        child: CachedNetworkImage(
                                          imageUrl: newsProvider.newsHeadlines!
                                              .articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
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
                                    ),
                                    Positioned(
                                      bottom: 20.h,
                                      child: Card(
                                        elevation: 5,
                                        color: AppColors.cardColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          height: 0.22.sh,
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 0.7.sw,
                                                child: Text(
                                                  newsProvider.newsHeadlines!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      color: AppColors.data,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 0.7.sw,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      newsProvider
                                                          .newsHeadlines!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .data,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    Text(
                                                      format.format(dateTime),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .data,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: newsProvider.isLoading
                ? Center(
                    child: SpinKitHourGlass(
                      color: Colors.black,
                      size: 60,
                    ),
                  )
                : newsProvider.error.isNotEmpty
                    ? Center(
                        child: Text(
                          'Error: ${newsProvider.error}',
                          style: TextStyle(
                              fontSize: 18.sp), // ScreenUtil font size
                        ),
                      )
                    : newsProvider.categoriesNews == null ||
                            newsProvider.categoriesNews!.articles!.isEmpty
                        ? Center(
                            child: Text(
                              'No news available',
                              style: TextStyle(
                                  fontSize: 18.sp), // ScreenUtil font size
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                newsProvider.categoriesNews!.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(newsProvider
                                  .categoriesNews!.articles![index].publishedAt
                                  .toString());
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: CachedNetworkImage(
                                        imageUrl: newsProvider.categoriesNews!
                                            .articles![index].urlToImage
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
                                              newsProvider.categoriesNews!
                                                  .articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.sp,
                                                  color: AppColors.data,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  newsProvider
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
    );
  }
}
/*ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18.h,
                                width: width * .3.w,
                                placeholder: (ctx, url) => Container(
                                  child: SpinKitHourGlass(
                                      size: 60.w,
                                      color: Colors.white), // ScreenUtil size
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
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          color: AppColors.data,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data!.articles![index]
                                              .source!.name
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: AppColors.Selectbtn,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
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
                  );*/




                  /*FutureBuilder<CategoriesNewsModel>(
              future: NewsViewModelRepository().fetchCategories('General'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitHourGlass(
                        size: 60.w, color: Colors.black), // ScreenUtil size
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 18.sp), // ScreenUtil font size
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.articles!.isEmpty) {
                  return Center(
                    child: Text(
                      'No news available',
                      style: TextStyle(fontSize: 18.sp), // ScreenUtil font size
                    ),
                  );
                } else {
                  return 
                }
              },
            ),*/