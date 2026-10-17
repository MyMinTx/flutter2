// import 'package:flutter/material.dart';
// import 'package:flutter2/main.dart';
// import 'package:flutter2/widgets/profile_header.dart';
// import 'package:flutter2/widgets/profile_stats.dart';
// import 'package:flutter2/widgets/action_buttons.dart';
// import 'package:flutter2/widgets/post_grid.dart';

// // ignore: camel_case_types
// class profile_page extends StatelessWidget {
//   const profile_page({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back_ios),
//         title: const Text(
//           'housemateloverclub',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
//             onPressed: () {
//               MyApp.of(context).toggleTheme(); // สั่งสลับธีม
//             },
//           ),
//           const Icon(Icons.more_horiz),
//           const SizedBox(width: 15),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 profile_header(),
//                 Expanded(child: profile_stats()),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'MINGYU & WONWOO',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 2),
//                   Text('SEVENTEEN 💎'),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 15),
//           const action_buttons(),
//           const SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: const [
//               Icon(Icons.grid_on),
//               Icon(Icons.movie_creation_outlined, color: Colors.grey),
//               Icon(Icons.person_pin_outlined, color: Colors.grey),
//             ],
//           ),
//           const Divider(height: 20, thickness: 1),
//           // ส่วนตารางโพสต์
//           const Expanded(child: post_grid()),
//         ],
//       ),
//     );
//   }
// }
