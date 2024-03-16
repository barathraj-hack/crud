import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String name;
  final String subName;
  final double price;

  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.subName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 150),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Name :' + ' ' + name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sub Name :' + ' ' + subName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Price :' + ' ₹' + price.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  ProductTile.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        subName = json['subName'] ?? '',
        price = json['price'] ?? 0;

  ProductTile copyWith({
    String? name,
    String? subName,
    double? price,
  }) {
    return ProductTile(
      name: name ?? this.name,
      price: price ?? this.price,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subName': subName,
      'price': price,
    };
  }
}
