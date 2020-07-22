import 'package:aquariusstore/components/no_image.dart';
import 'package:aquariusstore/controllers/product_controller.dart';
import 'package:aquariusstore/models/product.dart';
import 'package:aquariusstore/services/product_service.dart';
import 'package:aquariusstore/views/add_photos.dart';
import 'package:aquariusstore/views/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenProductItem extends StatelessWidget {
  final Product product;
  final ProductController productController = Get.find<ProductController>();
  GenProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      isThreeLine: true,
      leading: FittedBox(
        child: product.mainImageUrl == null
            ? NoImage()
            : Image.network(
                product.mainImageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
      ),
      title: Text(
        product.name,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('R\$' + product.price.toStringAsFixed(2)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt,
            ),
            onPressed: () => Get.to(AddPhotos(product: product)),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () => Get.to(
              AddProduct(product: this.product),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Exluir Produto'),
                  content: Text(
                      'Deseja realmente excluir o produto ${product.name}?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        ProductService().removeProduct(product);
                        productController.reload();
                        Get.close(1);
                      },
                      child: Text('Sim'),
                      textColor: Theme.of(context).accentColor,
                    ),
                    FlatButton(
                      onPressed: () => Get.close(1),
                      child: Text('Não'),
                      textColor: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
