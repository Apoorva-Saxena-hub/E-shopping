import 'package:api_use_ecomm/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/image1.jpg",
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        height: size.height * 0.3,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          const CircleAvatar(
                                            radius: 42,
                                            backgroundImage:
                                            AssetImage("assets/images/image2.jpg"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.black54)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9, horizontal: 12),
                                            child: const Text(
                                              "Subscribe",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.pink,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: const Text(
                                              "Follow",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "E-COMM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 35,
                                    ),
                                  ),
                                  const Text(
                                    "Shopping Mall",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "A place where people can buy and sell their favorite products, at a reasonable price.",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                       // Background color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
