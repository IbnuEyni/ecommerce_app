import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/create_bloc/create_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';

class CreatePage extends StatefulWidget {
  CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late TextEditingController _nameController = TextEditingController();

  late TextEditingController _priceController = TextEditingController();

  late TextEditingController _descriptionController = TextEditingController();

  Uint8List? _imageBytes;

  final ImagePicker _picker = ImagePicker();

  File? _image;

  Future<void> _imageFile() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: const Color(0xff3F51F3),
                    onPressed: () {
                      context.pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                        const CircleBorder(),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Add/Edit Product',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: _imageFile,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey[300],
                      child: _image == null
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image_rounded,
                                    size: 50,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextField('Name', _nameController),
              const SizedBox(height: 16.0),
              CustomTextField(
                'Price',
                _priceController,
                keyboardType: TextInputType.number,
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("\$"),
                ),
              ),
              const SizedBox(height: 16.0),
              CustomTextField('Description', _descriptionController,
                  maxLines: 4),
              const SizedBox(height: 16.0),
              BlocConsumer<CreateBloc, CreateState>(
                listener: (context, state) {
                  if (state is CreateProductError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is CreateProductLoaded) {
                    _nameController.clear();
                    _priceController.clear();
                    _descriptionController.clear();
                    _image = null;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product Created'),
                      ),
                    );
                    context.pop();
                  }
                },
                builder: (context, state) {
                  if (state is CreateProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ButtonWidget(
                    title: 'Add',
                    isFilled: true,
                    buttonWidth: double.infinity,
                    onPressed: () {
                      BlocProvider.of<CreateBloc>(context).add(
                        CreateProductEvent(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          price: _priceController.text,
                          imageUrl: _image?.path ?? 'images/defaultImage.jpg',
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    // } else {
    //   return const Center(child: Text('Something went wrong!'));
    // }
  }
}
