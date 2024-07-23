import 'package:api_use_ecomm/screens/product_detail/widget/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/cart_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  void _handleAddToCart(BuildContext context, Map product, int quantity) {
    Provider.of<CartModel>(context, listen: false).addItem(product, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product['image'],
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['title'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "\$${product['price']}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Category: ${product['category']}",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['description'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddToCart(
        product: product,
        onAddToCart: (product, quantity) => _handleAddToCart(context, product, quantity),
      ),
    );
  }
}
