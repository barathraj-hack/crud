import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/model/product_tile.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference productRef;

  DatabaseService() {
    productRef = _firestore.collection('products').withConverter<ProductTile>(
          fromFirestore: (snapshots, _) =>
              ProductTile.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
  }

  Stream<QuerySnapshot> getProduct() {
    return productRef.snapshots();
  }

  void addProductToDb(ProductTile productTile) async {
    productRef.add(productTile);
  }

  void updateProduct(String productId, ProductTile productTile) {
    productRef.doc(productId).update(productTile.toJson());
  }

  void deleteProduct(String productId) {
    productRef.doc(productId).delete();
  }
}
