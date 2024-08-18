import 'dart:io';

import '../bloc/create_bloc/create_bloc.dart';
import '../bloc/update_bloc/update_bloc.dart';
import '../widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatelessWidget {
  final String? id;

  const CreatePage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    File? _imageFile;

    void _pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    }

    void _onSave() {
      final String name = _nameController.text;
      final String category = _categoryController.text;
      final String priceText = _priceController.text;
      final String description = _descriptionController.text;

      if (name.isNotEmpty &&
          category.isNotEmpty &&
          priceText.isNotEmpty &&
          description.isNotEmpty) {
        final double price = double.tryParse(priceText) ?? 0.0;

        if (id != null) {
          BlocProvider.of<UpdateBloc>(context).add(UpdateProductEvent(
              id: '', name: '', description: '', imageUrl: '', price: ''));
        } else {
          BlocProvider.of<CreateBloc>(context).add(CreateProductEvent(
              id: '', name: '', description: '', imageUrl: '', price: ''));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all fields and upload an image."),
          ),
        );
      }
    }

    return Scaffold(
      body: BlocBuilder<CreateBloc, CreateState>(builder: (context, state) {
        if (state is CreateProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CreateProductLoaded) {
          return SingleChildScrollView(
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
                    onTap: _pickImage,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.grey[300],
                          child: _imageFile == null
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
                                  _imageFile!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField('Name', _nameController),
                  const SizedBox(height: 16.0),
                  _buildTextField('Category', _categoryController),
                  const SizedBox(height: 16.0),
                  _buildTextField(
                    'Price',
                    _priceController,
                    keyboardType: TextInputType.number,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("\$"),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextField('Description', _descriptionController,
                      maxLines: 4),
                  const SizedBox(height: 16.0),
                  ButtonWidget(
                    title: id != null ? 'Update' : 'Add',
                    isFilled: true,
                    buttonWidth: double.infinity,
                    onPressed: _onSave,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      }),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      Widget? suffixIcon,
      int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
