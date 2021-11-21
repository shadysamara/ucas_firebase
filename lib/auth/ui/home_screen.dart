import 'package:firebase_project/auth/providers/auth_provider.dart';
import 'package:firebase_project/ecommerce/ui/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddNewProduct());
          },
        ),
        appBar: AppBar(
          title: Text('HomeScreen'),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return provider.products.isEmpty
              ? Center(
                  child: Text('No Product found'),
                )
              : provider.products == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: provider.products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 4,
                                color: Colors.grey[400],
                                child: Image.network(
                                  provider.products[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    color: Colors.orange,
                                    child: Text(
                                      provider.products[index].productName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
        }));
  }
}
