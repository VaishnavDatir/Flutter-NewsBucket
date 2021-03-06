import 'package:NewsBucket/screens/category_news_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTitleDisplayWidget extends StatelessWidget {
  final String cTitle;
  final String cImgUrl;

  CategoryTitleDisplayWidget({
    @required this.cTitle,
    @required this.cImgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        Navigator.of(context).pushNamed(CategoryNews.routeName,
            arguments: {"caterogyName": cTitle, "caterogyImageUrl": cImgUrl});
      },
      child: Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          padding: EdgeInsets.all(5),
          // width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                cImgUrl,
                height: 40,
                // width: 75,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                cTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.workSans(
                    // color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
