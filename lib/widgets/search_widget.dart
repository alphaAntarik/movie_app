import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  TextEditingController textEditingController;
  Function setSearch;
  SearchBarWidget({
    Key? key,
    required this.textEditingController,
    required this.setSearch,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBarWidgetState();
  }
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
      child: Center(
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: SearchBar(
              controller: widget.textEditingController,
              elevation: const MaterialStatePropertyAll(5),
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
              ),
              side: MaterialStateProperty.all(const BorderSide(
                  color: const Color.fromARGB(255, 192, 169, 233))),
              shape: MaterialStateProperty.all(const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
              overlayColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 192, 169, 233)),
              shadowColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 192, 169, 233)),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 249, 249, 248)),
              hintText: 'Type keyword',
              hintStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white)),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
              onChanged: (String value) {
                print('value: $value');
                widget.setSearch(value);
              },
              onTap: () {
                print('tapped');
              },
              leading: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
