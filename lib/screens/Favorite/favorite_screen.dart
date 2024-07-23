import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List favoriteProducts;
  final Function(Map) onRemoveFavorite;

  const FavoriteScreen({
    Key? key,
    required this.favoriteProducts,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text('No favorites yet'))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.network(
                  product['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'],
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${product['price']}',
                        style: TextStyle(
                            fontSize: 14.0, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        product['category'],
                        style: TextStyle(
                            fontSize: 12.0, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    onRemoveFavorite(product);
                    Navigator.pop(context); // Go back to HomeScreen
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
