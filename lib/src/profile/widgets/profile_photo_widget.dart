import 'dart:io';

import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart';
import 'package:fluffyn_e_commerce/provider/local_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.read<AuthBloc>().state;
    final String email = (s is SuccessState) ? s.email : "";
    return ChangeNotifierProvider(
      create: (context) => LocalImageProvider(email),
      child: Consumer<LocalImageProvider>(
        builder: (context, value, child) {
          File? img = value.getImage();

          return InkWell(
            onTap: () {
              value.updateImage(email);
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
