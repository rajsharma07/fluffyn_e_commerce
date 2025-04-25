import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_cart_handling.dart';
import 'package:flutter/material.dart';

class ShowTransactionsWidget extends StatelessWidget {
  const ShowTransactionsWidget(this.email, {super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTransaction(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong!!"),
          );
        } else if (snapshot.hasData) {
          return (snapshot.data!.isEmpty)
              ? const Center(
                  child: Text("No data available"),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                      leading: Text(snapshot.data![index].quantity.toString()),
                      trailing: Text("₹${snapshot.data![index].price}"),
                      subtitle: Text(snapshot.data![index].date.toString()),
                    );
                  },
                );
        } else {
          return const Center(
            child: Text("Transaction data"),
          );
        }
      },
    );
  }
}
