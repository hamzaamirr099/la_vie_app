import 'package:flutter/material.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import 'package:la_vie/models/plant_model.dart';

class SingleBlogDescription extends StatelessWidget {
  final PlantModel blogItem;

  const SingleBlogDescription({Key? key, required this.blogItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          blogItem.imageUrl == ""
              ? Image.asset('assets/images/no_image_found.png')
              : Image.network(
                  "$baseUrl${blogItem.imageUrl}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 350,
                ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${blogItem.name}",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "${blogItem.description}",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultButton(
              childWidget: const Text(
                "Back to blogs",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
