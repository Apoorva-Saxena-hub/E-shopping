import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/constant.dart';
import '../../constants/my_searchBar.dart';
import '../Favorite/favorite_screen.dart';
import '../product_detail/product_detail.dart';

class HomeScreen extends StatefulWidget {
  final List favoriteProducts;
  final Function(List) onFavoriteUpdate;

  const HomeScreen({
    Key? key,
    required this.favoriteProducts,
    required this.onFavoriteUpdate,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _allProducts = [];
  List _filteredProducts = [];
  late List _favoriteProducts;
  List<String> _categories = [
    'All',
    'Electronics',
    'Jewelery',
    'Men\'s clothing',
    'Women\'s clothing'
  ];
  String _selectedCategory = 'All';

  Future<List> _getProduct() async {
    var url = Uri.parse(kProductUrl);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
    _favoriteProducts = widget.favoriteProducts;
    _getProduct().then((data) {
      setState(() {
        _allProducts = data;
        _filteredProducts = data;
      });
    });
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product['title'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts.where((product) {
          return product['category'].toString().toLowerCase() ==
              category.toLowerCase();
        }).toList();
      }
    });
  }

  void _toggleFavorite(Map product) {
    setState(() {
      if (_favoriteProducts.contains(product)) {
        _favoriteProducts.remove(product);
      } else {
        _favoriteProducts.add(product);
      }
      widget.onFavoriteUpdate(_favoriteProducts); // Notify MainScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shopping App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            MySearchBar(onSearch: _filterProducts),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(
                    favoriteProducts: _favoriteProducts,
                    onRemoveFavorite: (product) {
                      setState(() {
                        _favoriteProducts.remove(product);
                      });
                      widget.onFavoriteUpdate(_favoriteProducts);
                    },
                  ),
                ),
              ).then((_) {
                setState(() {}); // Ensure rebuild on return
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _filteredProducts = _allProducts;
                    });
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return GestureDetector(
                  onTap: () => _filterByCategory(category),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: _selectedCategory == category
                          ? Colors.amber
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              product['image'],
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${product['title']}",
                              maxLines: 2,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$ ${product['price']}"),
                                IconButton(
                                  onPressed: () => _toggleFavorite(product),
                                  icon: Icon(
                                    _favoriteProducts.contains(product)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  color: _favoriteProducts.contains(product)
                                      ? Colors.red
                                      : null, // Set color if favorite
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
