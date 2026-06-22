import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isFakka = product.category == '\u0641\u0627\u0643\u0651\u0629';
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isFakka
                  ? [AppTheme.primaryRed, AppTheme.darkRed]
                  : [const Color(0xFF1565C0), const Color(0xFF0D47A1)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isFakka ? Icons.monetization_on_outlined : Icons.wifi_outlined, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                Text(product.displayName, textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text(product.category, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
                const Spacer(),
                const Icon(Icons.arrow_back_ios_new, color: Colors.white54, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}