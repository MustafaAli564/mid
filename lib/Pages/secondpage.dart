import 'package:mid/Models/products.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Secondpage extends StatelessWidget {
  final Product prod;
  const Secondpage({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: prod.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                prod.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${prod.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating:
                                prod.rating.rate,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder:
                                (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                            },
                          ),
                          SizedBox(width: 5),
                          Text("(${prod.rating.count})"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                prod.description,
                maxLines: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
