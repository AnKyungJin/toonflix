import 'package:flutter/material.dart';
import "package:toonflix/models/webtoon_model.dart";
import 'package:toonflix/naver/detail_screen.dart';
import 'package:toonflix/services/api_service.dart';

class WebToon extends StatelessWidget {
  final WebtoonModel webtoon;

  const WebToon({super.key, required this.webtoon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(webtoon: webtoon),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(
                webtoon.thumb,
                headers: ApiService.header_netimage,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            webtoon.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }
}
