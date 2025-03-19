import 'package:flutter/material.dart';
import 'package:mid/Api/prods.dart';
import 'package:mid/Models/products.dart';
import 'package:mid/Cards/itemcard.dart';
import 'package:mid/Pages/secondpage.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  String selectedCategory = "All";
  Color selectedColor = Color(0xFFF5E6FA);
  Color defaultColor = Colors.white;

  List<Product> filterProducts(List<Product> products, String category) {
    if (category == "All") {
      return products;
    } else {
      return products.where((product) => product.category == category.toLowerCase()).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6FF),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found'));
                } else {
                  final filteredProducts = filterProducts(snapshot.data!, selectedCategory);

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Secondpage(prod: product),
                            ),
                          );
                        },
                        child: Itemcard(
                          title: product.title,
                          price: product.price,
                          rating: product.rating.rate,
                          image: product.image,
                          cat : product.category
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}