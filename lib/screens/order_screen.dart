import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/vodafone_api.dart';
import '../theme/app_theme.dart';

class OrderScreen extends StatefulWidget {
  final Product product;
  const OrderScreen({super.key, required this.product});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _receiverController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;
  bool _isSuccess = false;

  @override
  void dispose() {
    _receiverController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    final receiver = _receiverController.text.trim();
    final pin = _pinController.text.trim();

    if (receiver.length != 11 || !receiver.startsWith('01')) {
      _showError('\u0627\u0644\u0631\u062C\u0627\u0621 \u0625\u062F\u062E\u0627\u0644 \u0631\u0642\u0645 \u0647\u0627\u062A\u0641 \u0635\u062D\u064A\u062D \u0645\u0643\u0648\u0646 \u0645\u0646 11 \u0631\u0642\u0645');
      return;
    }
    if (pin.length != 6 || !pin.contains(RegExp(r'^\d{6}$'))) {
      _showError('\u0627\u0644\u0631\u0642\u0645 \u0627\u0644\u0633\u0631\u064A \u064A\u062C\u0628 \u0623\u0646 \u064A\u0643\u0648\u0646 6 \u0623\u0631\u0642\u0627\u0645');
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      final authData = await VodafoneApi.getSeamlessAndMsisdn();
      final accessToken = await VodafoneApi.getAccessToken(authData['seamlessToken']!);
      final result = await VodafoneApi.placeOrder(
        productId: widget.product.id,
        senderMsisdn: authData['msisdn']!,
        receiverMsisdn: receiver,
        pin: pin,
        accessToken: accessToken,
      );

      final code = result['code'];
      if (code != null && code != '0000') {
        setState(() {
          _isSuccess = false;
          _statusMessage = result['reason'] ?? '\u0641\u0634\u0644\u062A \u0627\u0644\u0639\u0645\u0644\u064A\u0629';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isSuccess = true;
          _statusMessage = '\u2705 \u062A\u0645 \u0625\u0631\u0633\u0627\u0644 \u0627\u0644\u0637\u0644\u0628 \u0628\u0646\u062C\u0627\u062D!';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isSuccess = false;
        _statusMessage = '\u274C \u062E\u0637\u0623: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFakka = widget.product.category == '\u0641\u0627\u0643\u0651\u0629';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.displayName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isFakka
                      ? [AppTheme.primaryRed, AppTheme.darkRed]
                      : [const Color(0xFF1565C0), const Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    isFakka ? Icons.monetization_on : Icons.wifi,
                    color: Colors.white,
                    size: 56,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.product.category,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            TextField(
              controller: _receiverController,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: const InputDecoration(
                labelText: '\u0631\u0642\u0645 \u0627\u0644\u0645\u0633\u062A\u0644\u0645',
                hintText: '01XXXXXXXXX',
                prefixIcon: Icon(Icons.phone_android),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pinController,
              textAlign: TextAlign.right,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: '\u0627\u0644\u0631\u0642\u0645 \u0627\u0644\u0633\u0631\u064A \u0641\u0648\u062F\u0627\u0641\u0648\u0646 \u0643\u0627\u0634',
                hintText: '6 \u0623\u0631\u0642\u0627\u0645',
                prefixIcon: Icon(Icons.lock_outline),
                counterText: '',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _placeOrder,
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text('\u0627\u0634\u062D\u0646 \u0627\u0644\u0622\u0646', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            if (_statusMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isSuccess
                      ? AppTheme.successGreen.withValues(alpha: 0.1)
                      : AppTheme.primaryRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isSuccess
                        ? AppTheme.successGreen.withValues(alpha: 0.3)
                        : AppTheme.primaryRed.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle : Icons.error_outline,
                      color: _isSuccess ? AppTheme.successGreen : AppTheme.primaryRed,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _statusMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: _isSuccess ? AppTheme.successGreen : AppTheme.primaryRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            if (_isSuccess) ...[
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('\u0627\u0644\u0639\u0648\u062F\u0629 \u0625\u0644\u0649 \u0627\u0644\u0631\u0626\u064A\u0633\u064A\u0629'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}