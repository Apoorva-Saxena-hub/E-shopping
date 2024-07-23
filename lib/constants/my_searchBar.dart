import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const MySearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.onSearch(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration:const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black54),
          hintText: 'Search products...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
