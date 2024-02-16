import 'package:flutter/material.dart';
import 'package:products_app/Helper/ApiBaseHelper.dart';
import 'package:products_app/widgets/product_detail.dart';

import '../Model/product_model.dart';

class GridWithCards extends StatefulWidget {
  const GridWithCards({super.key});

  @override
  State<GridWithCards> createState() => _GridWithCardsState();
}

class _GridWithCardsState extends State<GridWithCards> {

  late Future<List<SimpleProduct>> futureSimpleProductList;


  @override
  void initState() {
    super.initState();
    futureSimpleProductList = ApiBaseHelper().fetchSimpleProducts('/products');

  }

  @override
  Widget build(BuildContext context) {
    int gridCount = 2;

    return FutureBuilder<List<SimpleProduct>>(
      future: futureSimpleProductList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("An error has occurred!"));
        } else if (snapshot.hasData) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data!.length, // Set the itemCount to 3
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust based on your design
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(product: product),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 130, // Set a fixed height for the image
                        width: double.infinity,
                        child: Image.network(
                          product.images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          truncateWords(product.title, 5),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Price: \$${product.price}",
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          // Handle the case where there's no data
          return const Center(child: Text("No products found!"));
        }
      },
    );
  }
  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    if (words.length <= maxWords) {
      return text;
    }
    return words.sublist(0, maxWords).join(' ') + '...';
  }

}
