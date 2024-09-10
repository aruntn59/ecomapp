import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../block/CheckoutBloc.dart';
import '../block/cart_block.dart';
import '../constants/colors.dart';
import '../models/product_model.dart';
import 'cart_screen.dart';
import 'check_out_screen.dart';
import 'home_screen.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar
        (leading: IconButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

      },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstant.red,
            child: Icon(Icons.home,color: Colors.white,),)),centerTitle: true,
        title:  Text  (
          'Shope',
          style: GoogleFonts.palanquinDark(
              color: ColorConstant.red,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {

              int cartItemCount = 0;
              if (state is CartLoaded) {
                cartItemCount = state.cart.length;
              }
              return CircleAvatar(
                radius: 30,
                backgroundColor: ColorConstant.red,
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart,color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                    ),
                    if (cartItemCount > 0)
                      Positioned(
                        right: 0.5,
                        top: 1,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.yellow,
                          child: Text(
                            '$cartItemCount',
                            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail, fit: BoxFit.cover, width: double.infinity),
            SizedBox(height: 16),
            Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            // Text(product.description),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCart(product));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} added to cart!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CheckoutBloc(),
                            // child: CheckoutScreen(),
                          ),
                        ),
                      );
                    },
                    child: Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
