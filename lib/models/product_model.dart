class Product {
  final String id;
  final String name;
  final String category;
  final String displayName;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.displayName,
  });

  static const List<Product> fakkaProducts = [
    Product(id: 'Fakka_2.5_Unite', name: 'Fakka_2.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 2.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_4.25_Unite', name: 'Fakka_4.25_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 4.25 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_5_Unite', name: 'Fakka_5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_6_NewUnite', name: 'Fakka_6_NewUnite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 6 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_7_Unite', name: 'Fakka_7_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 7 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_9_Unite', name: 'Fakka_9_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 9 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_10_Unite', name: 'Fakka_10_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 10 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_10_NewUnite', name: 'Fakka_10_NewUnite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 10 \u062C\u0646\u064A\u0647 (\u062C\u062F\u064A\u062F)'),
    Product(id: 'Fakka_10.5_Unite', name: 'Fakka_10.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 10.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_11.5_Unite', name: 'Fakka_11.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 11.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_12_Unite', name: 'Fakka_12_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 12 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_12.5_Unite', name: 'Fakka_12.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 12.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_13_Unite', name: 'Fakka_13_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 13 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_13.5_Unite', name: 'Fakka_13.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 13.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_15_Unite', name: 'Fakka_15_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 15 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_15_NewUnite', name: 'Fakka_15_NewUnite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 15 \u062C\u0646\u064A\u0647 (\u062C\u062F\u064A\u062F)'),
    Product(id: 'Fakka_15.5_Unite', name: 'Fakka_15.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 15.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_16.5_Unite', name: 'Fakka_16.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 16.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_17.5_Unite', name: 'Fakka_17.5_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 17.5 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_19.5_NewUnite', name: 'Fakka_19.5_NewUnite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 19.5 \u062C\u0646\u064A\u0647 (\u062C\u062F\u064A\u062F)'),
    Product(id: 'Fakka_20_Unite', name: 'Fakka_20_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 20 \u062C\u0646\u064A\u0647'),
    Product(id: 'Fakka_26_Unite', name: 'Fakka_26_Unite', category: '\u0641\u0627\u0643\u0651\u0629', displayName: '\u0641\u0627\u0643\u0651\u0629 26 \u062C\u0646\u064A\u0647'),
  ];

  static const List<Product> maredProducts = [
    Product(id: 'Mared_10_Minuts', name: 'Mared_10_Minuts', category: '\u0645\u0627\u0631\u062F', displayName: '\u0645\u0627\u0631\u062F 10 \u062F\u0642\u0627\u064A\u0642'),
    Product(id: 'Mared_10_Flexs', name: 'Mared_10_Flexs', category: '\u0645\u0627\u0631\u062F', displayName: '\u0645\u0627\u0631\u062F 10 \u0641\u0644\u064A\u0643\u0633\u0627\u062A'),
    Product(id: 'Mared_10_Social', name: 'Mared_10_Social', category: '\u0645\u0627\u0631\u062F', displayName: '\u0645\u0627\u0631\u062F 10 \u0633\u0648\u0634\u064A\u0627\u0644'),
  ];

  static List<Product> get all => [...fakkaProducts, ...maredProducts];
}