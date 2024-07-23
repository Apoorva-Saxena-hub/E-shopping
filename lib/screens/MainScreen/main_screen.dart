import 'package:flutter/material.dart';
import '../Cart/cart_screen.dart';
import '../Favorite/favorite_screen.dart';
import '../Home/home_screen.dart';
import '../Profile/profile_screen.dart';
class MainScreen extends StatefulWidget {
  final List favoriteProducts;

  const MainScreen({Key? key, required this.favoriteProducts}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late List _favoriteProducts;

  @override
  void initState() {
    super.initState();
    _favoriteProducts = widget.favoriteProducts;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateFavorites(List products) {
    setState(() {
      _favoriteProducts = products;
    });
  }

  List<Widget> _screens() => [
    HomeScreen(onFavoriteUpdate: _updateFavorites, favoriteProducts: [],),
    FavoriteScreen(
      favoriteProducts: _favoriteProducts,
      onRemoveFavorite: (product) {
        setState(() {
          _favoriteProducts.remove(product);
        });
        _updateFavorites(_favoriteProducts);
      },
    ),
    CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

