// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/Constants/AppColors.dart';

class deTailScreen extends StatefulWidget {
  final String newImage;
  final String newTitle;
  final String newDaTe;
  final String author;
  final String description;
  final String content;
  final String source;
  const deTailScreen({
    Key? key,
    required this.newImage,
    required this.newTitle,
    required this.newDaTe,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }) : super(key: key);

  @override
  State<deTailScreen> createState() => _deTailScreenState();
}

class _deTailScreenState extends State<deTailScreen> {
  final format = DateFormat("MMM dd, yyyy");

  @override
  Widget build(BuildContext context) {
    final height = 1.sh; // screen height
    DateTime dateTime = DateTime.parse(widget.newDaTe);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.creameColor),
        surfaceTintColor: AppColors.background,
        backgroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(40.r),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage.isNotEmpty
                    ? widget.newImage
                    : 'https://example.com/default_image.jpg',
                fit: BoxFit.cover,
                placeholder: (ctx, url) => Center(
                  child: SpinKitHourGlass(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
            decoration: BoxDecoration(
              color: AppColors.Selectbtn,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            child: ListView(
              children: [
                Text(
                  widget.newTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: AppColors.data,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.source,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: AppColors.creameColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.creameColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: AppColors.creameColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
