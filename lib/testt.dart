// import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';
//
// import 'core/shared/components.dart';
// import 'features/presentations/main_app_layout/main_layout_screen.dart';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("Connection"),
//           ),
//           body: Builder(
//             builder: (BuildContext context) {
//               return OfflineBuilder(
//                 connectivityBuilder: (BuildContext context,
//                     ConnectivityResult connectivity, Widget child) {
//                   final bool connected = connectivity != ConnectivityResult.none;
//                   if(connected)
//                   {
//                     return MainLayout();
//                   }
//                   else
//                   {
//                     return buildNoInternetWidget();
//                   }
//                 },
//                 child: Container(),
//               );
//             },
//           ),
//       ),
//     );
//   }
// }
//
