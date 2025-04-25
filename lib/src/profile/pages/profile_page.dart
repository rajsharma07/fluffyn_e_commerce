import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_event.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_event.dart';
import 'package:fluffyn_e_commerce/bloc/profile_page/profile_page_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:fluffyn_e_commerce/src/profile/widgets/profile_photo_widget.dart';
import 'package:fluffyn_e_commerce/src/profile/widgets/show_transactions_widget.dart';
import 'package:fluffyn_e_commerce/src/profile/widgets/update_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  String getEmail(BuildContext ctx) {
    final s = ctx.read<AuthBloc>().state;
    return (s is auth.SuccessState) ? s.email : "";
  }

  @override
  Widget build(BuildContext context) {
    final String email = getEmail(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProfilePageBloc()..add(GetUserDataEvent(email)),
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
            builder: (context, state) {
          if (state is FailureState) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                MySnackBar.showSnackBar(
                  context,
                  state.failure.messages ?? "Something went wrong!!!",
                );
              },
            );
            return Center(
              child: TextButton(
                onPressed: () {
                  context.read<ProfilePageBloc>().add(
                        GetUserDataEvent(email),
                      );
                },
                child: const Text(
                  "Some error occured!, \nclick Here to retry",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (state is SuccessState) {
            return Column(
              children: [
                const SizedBox(height: 30),
                const ProfilePhotoWidget(),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      final ctx = context;
                      showBottomSheet(
                        context: context,
                        enableDrag: true,
                        showDragHandle: true,
                        constraints: const BoxConstraints(maxHeight: 300),
                        builder: (context) {
                          return UpdateProfileWidget(ctx, state.user);
                        },
                      );
                    },
                    child: const Text("Update Profile"),
                  ),
                ),
                Text(
                  state.user.name ?? "NA",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Phone No. : ${state.user.phone ?? "No phone number avaialble"}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('My Transaction'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showBottomSheet(
                      showDragHandle: true,
                      enableDrag: true,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.7),
                      context: context,
                      builder: (context) {
                        return ShowTransactionsWidget(email);
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('Cart'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Saved Addresses'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title:
                      const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
              ],
            );
          } else if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Profile Page"),
            );
          }
        }),
      ),
    );
  }
}
