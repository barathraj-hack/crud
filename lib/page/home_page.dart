import 'dart:async';

import 'package:crud/model/product_tile.dart';
import 'package:crud/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService databaseService = DatabaseService();

  TextEditingController nameController = TextEditingController();
  TextEditingController subNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  updateProduct(String productId, ProductTile productTile) {
    nameController.text = productTile.name;
    subNameController.text = productTile.subName;
    priceController.text = productTile.price.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 190,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: subNameController,
                  decoration: InputDecoration(
                    hintText: 'Sub Name',
                  ),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        double price =
                            double.tryParse(priceController.text) ?? 0.0;
                        ProductTile updateProduct = productTile.copyWith(
                          name: nameController.text,
                          subName: subNameController.text,
                          price: price,
                        );
                        databaseService.updateProduct(productId, updateProduct);
                        Navigator.pop(context);
                        nameController.clear();
                        subNameController.clear();
                        priceController.clear();
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future createProduct() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 190,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: subNameController,
                  decoration: InputDecoration(
                    hintText: 'Sub Name',
                  ),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        double price =
                            double.tryParse(priceController.text) ?? 0.0;
                        ProductTile productTile = ProductTile(
                          name: nameController.text,
                          subName: subNameController.text,
                          price: price,
                        );
                        databaseService.addProductToDb(productTile);
                        Navigator.pop(context);
                        nameController.clear();
                        subNameController.clear();
                        priceController.clear();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text(
            'CRUD - OPERATION',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: databaseService.getProduct(),
        builder: (context, snapshot) {
          List products = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              ProductTile productTile = products[index].data();
              String productId = products[index].id;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: createProduct,
                          child: const Text(
                            'Create',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () =>
                              updateProduct(productId, productTile),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MaterialButton(
                          color: Colors.red,
                          onPressed: () =>
                              databaseService.deleteProduct(productId),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    title: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Name: ' + ' ' + productTile.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Sub Name: ' + ' ' + productTile.subName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Price: ' + ' ' + productTile.price.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
