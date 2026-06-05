import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' show RatingBar;

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Screen')),
      body: Center(
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ),
    );
  }
}
