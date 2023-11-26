import 'package:flutter/material.dart';
import 'package:movie_app/widgets/backgrountfilter.dart';

import '../screens/moviedetails_screen.dart';

class MovieItemWidget extends StatelessWidget {
  final String name;
  final String desc;
  final String img;

  MovieItemWidget(
      {Key? key, required this.img, required this.name, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MovieDetailsScreen(img: img, desc: desc, name: name)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "http://image.tmdb.org/t/p/w500/$img",
            ), // Replace with your image asset
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            const BackgroundFilter(),
            Positioned(
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            desc,
                            maxLines: 3,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
