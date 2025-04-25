import 'dart:io';

import 'package:fluffyn_e_commerce/provider/local_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalImageProvider(id),
      child: Consumer<LocalImageProvider>(
        builder: (context, value, child) {
          File? img = value.getImage();

          return InkWell(
            onTap: () {
              value.updateImage(id);
            },
            child: (img == null)
                ? const CircleAvatar(
                    radius: 100,
                    child: Icon(Icons.add_a_photo),
                  )
                : CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(img)..evict(),
                    key: UniqueKey(),
                  ),
          );
        },
      ),
    );
  }
}
