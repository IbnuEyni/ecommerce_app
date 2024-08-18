import 'package:ecommerce_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/detail_bloc/detail_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/number_card.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  void _deleteItem(BuildContext context) {
    // Trigger the delete item event (assuming you have a delete event in the Bloc)
    // context.read<DetailBloc>().add(DeleteProductEvent(id: id)); // Uncomment and use your delete event

    context.pop(); // Use go_router's pop method For now, just navigate back
  }

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>().add(DetailProductEvent(id: id));
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          final ourItem = state.product;
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Image.network(
                            ourItem.imageUrl,
                            width: 430,
                            height: 286,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 20,
                            color: const Color(0xff3F51F3),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(ourItem.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    )),
                              ),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const Text('4',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ourItem.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('\$${ourItem.price}',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Size:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 6.0),
                            height: 50,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return NumberCard(size: '${index + 39}');
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system,'
                            'where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature '
                            'provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are '
                            'typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal'
                            ' and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonWidget(
                                title: 'DELETE',
                                buttonWidth: 152,
                                isFilled: false,
                                onPressed: () => _deleteItem(context),
                              ),
                              ButtonWidget(
                                title: 'UPDATE',
                                buttonWidth: 152,
                                isFilled: true,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/update',
                                    arguments: ourItem.id.toString(),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
