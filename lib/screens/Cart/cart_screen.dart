import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          // Calculate the total amount
          final double totalAmount = cart.items.fold(
            0.0,
                (sum, item) => sum + (item['price'] * item['quantity']),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.network(
                              item['image'],
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, size: 80);
                              },
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Category: ${item['category']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Amount: \$${item['price'] * item['quantity']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (item['quantity'] > 1) {
                                            cart.updateItemQuantity(item, item['quantity'] - 1);
                                          }
                                        },
                                      ),
                                      Text('${item['quantity']}'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          cart.updateItemQuantity(item, item['quantity'] + 1);
                                        },
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          cart.removeItem(item);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
