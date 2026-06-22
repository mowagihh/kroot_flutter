import 'package:flutter_test/flutter_test.dart';
import 'package:kroot_flutter/models/product_model.dart';

void main() {
  group('Product Model', () {
    test('all products list', () => expect(Product.all.length, 25));
    test('fakka products', () => expect(Product.fakkaProducts.length, 22));
    test('mared products', () => expect(Product.maredProducts.length, 3));
    test('product has required fields', () {
      expect(Product.fakkaProducts.first.id, isNotEmpty);
    });
  });
}