

import 'package:flutter/material.dart';
import 'package:stream2/blocs/products_bloc.dart';
import 'package:stream2/model/product.dart';


class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  ProductsBloc  productsBloc = ProductsBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    productsBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productsBloc.productStreamStream,
      // ignore: missing_return
      builder: (_, AsyncSnapshot<List<Product>> snapshot){
        switch (snapshot.connectionState){


          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),

          );
          break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasError){
              return Text('Error');
            }else{
              List<Product> products=snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount:products.length,
                    itemBuilder: (context ,int index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(products[index].title),
                            Text(products[index].qty.toString()),
                            RaisedButton(onPressed: (){
                              
                              productsBloc.addproduct.add(products[index]);
                            },child: Text('ADD NOW'),),
                            RaisedButton(onPressed: (){
                              productsBloc.removeproduct.add(products[index]);
                            },child: Text('REMOVE'),),


                          ],
                        ),
                      );


                }),
              );
            }
            break;
        }

      },
    );
  }
}
