import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_event.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget(this.ctx, this.user, {super.key});
  final UserModel user;
  final BuildContext ctx;

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _inputController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _inputController.text = widget.user.name ?? "";
    _phoneController.text = widget.user.phone ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageBloc(),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
        builder: (context, state) {
          if (state is FailureState) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                MySnackBar.showSnackBar(context,
                    state.failure.messages ?? "Something went wrong!!!");
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _inputController,
                      decoration: const InputDecoration(label: Text("Name:")),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                          return 'Name can only contain letters and spaces';
                        }
                        if (value.trim().length < 3) {
                          return 'Name must be at least 3 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text("Phone Number: "),
                      ),
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Button color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      onPressed: (state is LoadingState)
                          ? null
                          : () {
                              if (formkey.currentState!.validate()) {
                                UserModel newUser = UserModel(
                                    email: widget.user.email,
                                    name: _inputController.text,
                                    phone: _phoneController.text);
                                context.read<ProfilePageBloc>().add(
                                      UpdateUserEvent(newUser),
                                    );
                                widget.ctx.read<ProfilePageBloc>().add(
                                      GetUserDataEvent(widget.user.email),
                                    );
                                Navigator.of(context).pop();
                              }
                            },
                      child: const Text("Update"),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
