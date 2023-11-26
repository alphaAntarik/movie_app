import 'package:flutter/material.dart';

import 'package:movie_app/widgets/search_widget.dart';

import '../services/api_service.dart';
import 'moviewidget.dart';

class MovieListScreen extends StatefulWidget {
  String item;

  MovieListScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String search = "nodata";
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          textEditingController: textEditingController,
          setSearch: (val) {
            setState(() {
              search = val;
              print(search);
            });
          },
        ),
        FutureBuilder(
          future: ApiServices().createAlbum(widget.item),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.results == null) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (context, index) {
                    final movieTitle = snapshot.data!.results![index].title;
                    final img = snapshot.data!.results![index].backdropPath;
                    final movieOverview =
                        snapshot.data!.results![index].overview;

                    if (search == "nodata" ||
                        movieTitle!
                            .toLowerCase()
                            .contains(search.toLowerCase())) {
                      return Dismissible(
                        key: Key(snapshot.data!.results![index].title!),
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          // Implement your custom logic to confirm the dismissal
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Delete'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          final deletedItem =
                              snapshot.data!.results!.removeAt(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Item deleted'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() {
                                    snapshot.data!.results!
                                        .insert(index, deletedItem);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: MovieItemWidget(
                            name: "$movieTitle",
                            desc: "$movieOverview",
                            img: img!,
                            id: index),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
