import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DisplayRating extends StatelessWidget {
  const DisplayRating(this.rating, {super.key});
  final Rating rating;
  @override
  Widget build(BuildContext context) {
    int rate = rating.rate.toInt();
    int empytStars = (rating.rate - rate > 0) ? 5 - rate - 1 : 5 - rate;
    return Row(
      children: [
        ...List.generate(
          rate,
          (index) {
            return Icon(
              Icons.star,
              color: Colors.amber[600],
            );
          },
        ),
        if (rating.rate - rate > 0)
          Stack(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.amber[600],
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: (rating.rate - rate),
                  child: Icon(
                    Icons.star,
                    color: Colors.amber[600],
                  ),
                ),
              )
            ],
          ),
        ...List.generate(
          empytStars,
          (index) {
            return Icon(
              Icons.star_border,
              color: Colors.amber[600],
            );
          },
        ),
        Text("(${rating.count})"),
      ],
    );
  }
}
