import 'package:ecommerce_app/features/product/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class _SearchModal extends StatelessWidget {
  final double currentPrice;
  final ValueChanged<double> onPriceChanged;

  const _SearchModal({
    required this.currentPrice,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCategoryField(),
            const SizedBox(height: 20),
            _buildPriceSlider(),
            const SizedBox(height: 40),
            ButtonWidget(
              title: 'Apply',
              isFilled: true,
              buttonWidth: double.infinity,
              onPressed: () {
                // Handle apply action
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            // Handle category change
          },
        ),
      ],
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Slider(
          value: currentPrice,
          min: 0,
          max: 100,
          divisions: 100,
          label: currentPrice.round().toString(),
          onChanged: onPriceChanged,
        ),
      ],
    );
  }
}
