import 'package:ecomapp/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../block/cart_block.dart';
import '../models/product_model.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4, // Set the number of columns in the grid
      mainAxisSpacing: 3,
      crossAxisSpacing: 4,
      children: List.generate(products.length, (index) {
        final product = products[index];
        // Customize the crossAxisCellCount and mainAxisCellCount for each item
        return StaggeredGridTile.count(
          crossAxisCellCount: _getCrossAxisCellCount(index),
          mainAxisCellCount: _getMainAxisCellCount(index),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Helper methods to determine the size of each tile based on index
  int _getCrossAxisCellCount(int index) {
    switch (index) {
      case 0:
        return 2;
      case 1:
      case 2:
        return 1;
      case 3:
        return 1;
      case 4:
        return 2;
      case 5:
      case 6:
        return 1;
      case 7:
        return 2;
      case 8:
        return 1;
      case 9:
        return 1;
      case 10:
        return 2;
      default:
        return 1;
    }
  }

  int _getMainAxisCellCount(int index) {
    switch (index) {
      case 0:
        return 2;
      case 1:
      case 2:
        return 1;
      case 3:
        return 2;
      case 4:
        return 3;
      case 5:
      case 6:
        return 1;
      case 7:
        return 2;
      case 8:
        return 2;
      case 9:
        return 1;
      case 10:
        return 3;
      default:
        return 1;
    }
  }
}
