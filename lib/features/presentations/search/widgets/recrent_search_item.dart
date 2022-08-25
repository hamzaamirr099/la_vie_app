import 'package:flutter/material.dart';

class RecentSearchItem extends StatelessWidget {
  final String recentSearchText;
  RecentSearchItem({Key? key, required this.recentSearchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        debugPrint("Recent search");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            const Icon(Icons.watch_later_outlined, color: Colors.grey,),
            const SizedBox(width: 10.0,),
            Text(recentSearchText, style: const TextStyle(color: Colors.grey),),
            const Spacer(),
            const Icon(Icons.highlight_remove_outlined, color: Colors.grey,),

          ],
        ),
      ),
    );
  }
}
