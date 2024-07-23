import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final Map product;
  final void Function(Map product, int quantity) onAddToCart;

  const AddToCart({super.key, required this.product, required this.onAddToCart});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter, // Aligns the widget to the bottom center
      child: Padding(
        padding: const EdgeInsets.only(left : 30.0,right: 4.0,top: 4.0,bottom: 4.0),
        child: Container(
          width: double.infinity, // Takes full width
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 130, // Fixed width to ensure consistent spacing
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.blueGrey[800],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentIndex > 1) {
                          setState(() {
                            currentIndex--;
                          });
                        }
                      },
                      iconSize: 20,
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentIndex.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex++;
                        });
                      },
                      iconSize: 20,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onAddToCart(widget.product, currentIndex);
                  const snackBar = SnackBar(
                    content: Text(
                      "Successfully added!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange, // Button color
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
