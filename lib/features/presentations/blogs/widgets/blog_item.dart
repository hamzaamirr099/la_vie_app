import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/features/presentations/blogs/screens/single_blog_description.dart';
import 'package:la_vie/models/plant_model.dart';

import '../../../../core/shared/constants.dart';

class BlogItem extends StatelessWidget {

  final PlantModel blogItem;
  const BlogItem({Key? key, required this.blogItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SingleBlogDescription(blogItem: blogItem)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: blogItem.imageUrl == ""? Image.asset('assets/images/no_image_found.png', fit: BoxFit.cover, height: 120, width: 120,) :Image.network(
                    '$baseUrl${blogItem.imageUrl}',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2 days ago", style: TextStyle(color: mainGreenColor),),
                        SizedBox(height: 5,),
                        Text(
                          "${blogItem.name}",
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${blogItem.description}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
