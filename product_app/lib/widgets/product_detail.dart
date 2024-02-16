import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_app/Model/product_model.dart';

class ProductDetails extends StatelessWidget {
  final SimpleProduct product; // Assuming you pass the product to this page

  ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // PageView for images
          SizedBox(
            height: 300.0,
            child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return Image.network(product.images[index],fit: BoxFit.cover,);
              },
              itemCount: product.images.length,
              pagination: SwiperPagination(),
              // control: SwiperControl(),
            ),
          ),
          // Title, price, and description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Price: \$${product.price}",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text( "Product Description",
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
            product.description,
            style: TextStyle(fontSize: 16.0),
           ),
          ),
        ],
      ),
    );
  }
}