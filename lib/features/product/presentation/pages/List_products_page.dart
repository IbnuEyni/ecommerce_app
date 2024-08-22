import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/list_products/list_products_bloc.dart';
import '../widgets/product_card_widget.dart';

class ListProductsPage extends StatelessWidget {
  const ListProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListProductsBloc>(context).add(ListEvent());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.push('/signin');
                        },
                        child: Container(
                          width: 40,
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 207, 206, 206),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'July 14, 2023',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffAAAAAA)),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hello, ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Yonannes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_on_outlined,
                      color: Color.fromARGB(255, 173, 173, 173),
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<ListProductsBloc>().add(ListEvent());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          side: BorderSide(
                            color: Color.fromARGB(255, 219, 219, 219),
                          ),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Products',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffD9D9D9),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: Color(0xffD9D9D9),
                          size: 30,
                        ),
                      ),
                    ),
                    onTap: () {
                      context.push('/search');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: BlocBuilder<ListProductsBloc, ListProductsState>(
                  builder: (context, state) {
                    if (state is ListProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ListProductsLoaded) {
                      final items = state.products;
                      return ListView.builder(
                        key: const Key('List_products'),
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
                      return const Center(
                          child: Text('Failed to load products'));
                    } else {
                      return const Center(child: Text('No products available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff3F51F3),
          shape: const CircleBorder(eccentricity: 0.7),
          onPressed: () {
            context.push('/create');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    required Key key,
    required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
