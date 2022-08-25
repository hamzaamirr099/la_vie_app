import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/utils/bloc/blogs_bloc/blog_cubit.dart';
import 'package:la_vie/core/utils/bloc/blogs_bloc/blog_states.dart';
import '../../../../core/shared/constants.dart';
import '../widgets/blog_item.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlogCubit blogCubit = BlogCubit.get(context);
    blogCubit.getAllBlogs(token: userToken);
    return BlocConsumer<BlogCubit, BlogStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90.0,
            title: const Text(
              "Blogs",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              ConditionalBuilder(
                  condition: blogCubit.allBlogs.isNotEmpty,
                  builder: (context) => Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogItem(blogItem: blogCubit.allBlogs[index],);
                      },
                      itemCount: blogCubit.allBlogs.length, //here will be the length of the array of the notifications
                    ),
                  ),
                  fallback: (context) => Expanded(
                    child: RefreshIndicator(
                      displacement: 50.0,
                      onRefresh: (){
                        return blogCubit.getAllBlogs(token: userToken);
                      },
                      child: ListView(
                        // physics: BouncingScrollPhysics(),
                        children:
                        [
                          SizedBox(height: MediaQuery.of(context).size.height/3,),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
              ),

            ],
          ),
        );
      },
    );
  }
}
