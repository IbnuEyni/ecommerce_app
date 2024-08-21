import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/list_products/list_products_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _currentPrice = 50;

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return _SearchModal(
          currentPrice: _currentPrice,
          onPriceChanged: (value) {
            setState(() {
              _currentPrice = value;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchBar(context),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ListProductsBloc, ListProductsState>(
                builder: (context, state) {
                  if (state is ListProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ListProductsLoaded) {
                    final items = state.products;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          onTap: () async {
                            context.push('/detail/${item.id}');
                          },
                          child: ProductCardWidget(item: item),
                        );
                      },
                    );
                  } else if (state is ListProductsError) {
                    return const Center(child: Text('Failed to load products'));
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: const Color(0xff3F51F3),
        onPressed: () {
          context.pop();
        },
      ),
      title: const Center(
        child: Text(
          'Search Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 209, 207, 207),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.arrow_forward,
                  color: Color(0xff3F51F3),
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff3F51F3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              _showSearchModal(context);
            },
          ),
        ),
      ],
    );
  }
}

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

class _ItemCard extends StatelessWidget {
  final Product item;
  final VoidCallback onTap;

  const _ItemCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
      child: Image.asset(
        item.imageUrl,
        width: double.infinity,
        height: 250,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name, style: const TextStyle(fontSize: 18)),
              Text('\$${item.price}', style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const Text(
                '4',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
