import 'package:NewsBucket/mconstants.dart';
import 'package:NewsBucket/screens/category_news_screen.dart';
import 'package:flutter/material.dart';

class CategoryTitleDisplayWidget extends StatelessWidget {
  final String cTitle;
  final String cImgUrl;

  CategoryTitleDisplayWidget({
    @required this.cTitle,
    @required this.cImgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: cTitle,
      child: InkWell(
        borderRadius: BorderRadius.all(const Radius.circular(10)),
        onTap: () {
          Navigator.of(context).pushNamed(CategoryNews.routeName,
              arguments: {"caterogyName": cTitle, "caterogyImageUrl": cImgUrl});
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(5),
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
              const SizedBox(
                height: 6,
              ),
              Text(cTitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MConstant.fontWorkSans16),
            ],
          ),
        ),
      ),
    );
  }
}
