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
          margin: EdgeInsets.only(right: 10),
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
          )

          /* Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                cImgUrl,
                height: 75,
                width: 125,
              ),
              // child: CachedNetworkImage(
              //   imageUrl: cImgUrl,
              //   height: 75,
              //   width: 125,
              //   fit: BoxFit.cover,
              // ),
            ),
            Container(
              alignment: Alignment.center,
              height: 75,
              width: 125,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black45),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    cTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ), */
          ),
    );
  }
}
