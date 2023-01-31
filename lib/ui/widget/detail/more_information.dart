import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:trouver/common/app_color.dart';
import 'package:trouver/model/movie_detail_model.dart';

class MoreInformationWidget extends StatelessWidget {
  const MoreInformationWidget({
    super.key,
    required this.status,
    required this.tagline,
    required this.pCompanies,
    required this.pCountries,
    required this.adult,
    required this.language,
    required this.sLanguage,
    required this.budget,
    required this.revenue,
  });
  final String status, tagline, language;
  final int budget, revenue;
  final bool? adult;
  final List<ProductionCompanies> pCompanies;
  final List<ProductionCountries> pCountries;
  final List<SpokenLanguages> sLanguage;
  static Color color = ColorApp.accent1;
  static TextStyle contentStyle = TextStyle(
    color: const Color(0xffE1E1E1),
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );

  String _adultToString() {
    if (adult!) {
      return "Yes";
    } else {
      return "No";
    }
  }

  String _pCompaniesToString() {
    String text = "";
    for (var i = 0; i < pCompanies.length; i++) {
      text += pCompanies[i].name.toString();
      if (i < pCompanies.length - 1) {
        text += ", ";
      }
    }
    return text;
  }

  String _pCountriesToString() {
    String text = "";
    for (var i = 0; i < pCountries.length; i++) {
      text += pCountries[i].name.toString();
      if (i < pCountries.length - 1) {
        text += ", ";
      }
    }
    return text;
  }

  String _sLanguageToString() {
    String text = "";
    for (var i = 0; i < sLanguage.length; i++) {
      text += sLanguage[i].englishName.toString();
      if (i < sLanguage.length - 1) {
        text += ", ";
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.13)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("More Information", style: textTheme.headline4),
              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status", style: textTheme.bodyText1),
                        Text(status, style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Tagline", style: textTheme.bodyText1),
                        Text(tagline == "" ? "-" : tagline,
                            style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Production Companies",
                            style: textTheme.bodyText1),
                        Text(_pCompaniesToString(), style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Production Countries",
                            style: textTheme.bodyText1),
                        Text(_pCountriesToString(), style: contentStyle),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adult", style: textTheme.bodyText1),
                        Text(_adultToString(), style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Language", style: textTheme.bodyText1),
                        Text(language, style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Spoken Language", style: textTheme.bodyText1),
                        Text(_sLanguageToString(), style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Budget", style: textTheme.bodyText1),
                        Text("\$ $budget", style: contentStyle),
                        SizedBox(height: 8.h),
                        Text("Revenue", style: textTheme.bodyText1),
                        Text("\$ $revenue", style: contentStyle),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
