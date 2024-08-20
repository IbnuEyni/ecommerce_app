import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/detail_bloc/detail_bloc.dart';
import '../bloc/update_bloc/update_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';

class UpdatePage extends StatefulWidget {
  final String id;
  const UpdatePage({super.key, required this.id});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();

    if (widget.id.isNotEmpty) {
      BlocProvider.of<DetailBloc>(context)
          .add(DetailProductEvent(id: widget.id));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.id.isNotEmpty) {
      BlocProvider.of<DetailBloc>(context).stream.listen((state) {
        if (state is DetailLoaded) {
          final product = state.product;
          _nameController.text = product.name;
          _priceController.text = product.price.toString();
          _descriptionController.text = product.description;
          _image = File(product.imageUrl); // Load existing image
          setState(() {});
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _saveItem(BuildContext context) {
    final String name = _nameController.text;
    final String priceText = _priceController.text;
    final String description = _descriptionController.text;
    final String imageUrl =
        _image?.path ?? ''; // Assuming image path as URL for simplicity

    if (name.isNotEmpty &&
        priceText.isNotEmpty &&
        description.isNotEmpty &&
        imageUrl.isNotEmpty) {
      BlocProvider.of<UpdateBloc>(context).add(
        UpdateProductEvent(
          id: widget.id,
          name: name,
          price: priceText,
          description: description,
          imageUrl: imageUrl,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and upload an image."),
        ),
      );
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
                      Navigator.pop(context);
                    },
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
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[300],
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.fill,
                        )
                      : Center(
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
                        ),
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
              BlocConsumer<UpdateBloc, UpdateState>(
                listener: (context, state) {
                  if (state is UpdateProductLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product updated successfully!'),
                      ),
                    );
                    // context.pop();
                    context.go('/');
                  } else if (state is UpdateProductError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdateProductLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ButtonWidget(
                    title: 'Save',
                    isFilled: true,
                    buttonWidth: double.infinity,
                    onPressed: () {
                      _saveItem(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _image = null;
    super.dispose();
  }
}
