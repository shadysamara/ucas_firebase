import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:firebase_project/ecommerce/providers/product_provider.dart';

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            color: Colors.grey[400],
                            child: provider.pickedFile == null
                                ? Container()
                                : Image.file(
                                    provider.pickedFile,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned.fill(
                              child: GestureDetector(
                            onTap: () {
                              provider.pickImage();
                            },
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: provider.productName,
                        validateFunction: provider.validateNull,
                        label: 'Product Name',
                      ),
                      CustomTextField(
                        controller: provider.productDescription,
                        validateFunction: provider.validateNull,
                        label: 'Product Description',
                      ),
                      CustomTextField(
                        controller: provider.productQuantity,
                        validateFunction: provider.validateNull,
                        label: 'Product Quantity',
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: provider.productPrice,
                        validateFunction: provider.validateNull,
                        label: 'Product Price',
                        textInputType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: RaisedButton(
                    child: Text('Add Product'),
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      provider.addProduct();
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  Function validateFunction;
  TextEditingController controller;
  String label;
  TextInputType textInputType;
  CustomTextField(
      {@required this.validateFunction,
      @required this.controller,
      @required this.label,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        keyboardType: textInputType,
        validator: (String x) => validateFunction(x),
        controller: this.controller,
        decoration: InputDecoration(
            labelText: this.label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
