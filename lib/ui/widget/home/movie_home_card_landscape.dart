import 'package:flutter/material.dart';
import 'package:trouver/ui/detail/detail_page.dart';

class MovieHomeCardLandscape extends StatelessWidget {
  MovieHomeCardLandscape(
      {Key? key,
      required this.id,
      required this.gambar,
      required this.judul,
      required this.penonton,
      required this.rating})
      : super(key: key);
  int id;
  String gambar, judul, penonton, rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DetailPage(id: id)));
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          height: 170,
          width: 116,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FittedBox(
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/loading.gif",
                      image: "https://image.tmdb.org/t/p/w500" + gambar),
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: 58,
                  width: double.infinity,
                  color: Color.fromARGB(201, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              judul,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 213, 213, 213),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              penonton,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromARGB(255, 175, 175, 175),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Color.fromARGB(255, 196, 181, 48),
                          ),
                          SizedBox(width: 4),
                          Text(
                            rating,
                            style: TextStyle(
                              color: Color.fromARGB(255, 196, 181, 48),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
