

import 'package:stream2/contracts/disposable.dart';
import 'package:stream2/model/product.dart';
import 'dart:async';

class ProductsBloc implements Disposable{

  List<Product> products;
 final StreamController<List<Product>> _prodeuctListStreamController = StreamController<List<Product>>();
 Stream<List<Product>> get productStreamStream=>_prodeuctListStreamController.stream;//out from StreamController
  StreamSink<List<Product>> get productStreamSink=>_prodeuctListStreamController.sink;//in to StreamController>>ياخذ داتا

  final StreamController<Product> _addprodeuctStreamController = StreamController<Product>();
  StreamSink<Product> get addproduct=>_addprodeuctStreamController.sink;
  final StreamController<Product> _removeprodeuctStreamController = StreamController<Product>();
  StreamSink<Product> get removeproduct=>_removeprodeuctStreamController.sink;


  ProductsBloc(){
    products=[
      Product("1","ali",1),
      Product("2","mohamme",2),
      Product("3","sammer",3),
      Product("4","omar",4),



    ];
    _prodeuctListStreamController.add(products);
    _addprodeuctStreamController.stream.listen(_addproduct);
    _removeprodeuctStreamController.stream.listen(_removeproduct);

  }
  void _addproduct(Product product){
    products.add(product);
    productStreamSink.add(products);

  }
  void _removeproduct(Product product){
    products.remove(product);
    productStreamSink.add(products);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _prodeuctListStreamController.close();
    _addprodeuctStreamController.close();
    _removeprodeuctStreamController.close();
  }

}