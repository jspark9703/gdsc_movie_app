// import 'package:flutter/material.dart';

// class DialogSearchBar extends StatefulWidget {
//   const DialogSearchBar({super.key});

//   @override
//   State<DialogSearchBar> createState() => _DialogSearchBarState();
// }

// class _DialogSearchBarState extends State<DialogSearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     return SearchAnchor(
//       builder: (context, controller) => SearchBar(
//           controller: controller,
//           padding: const MaterialStatePropertyAll<EdgeInsets>(
//               EdgeInsets.symmetric(horizontal: 16.0)),
//           onTap: () {
//             controller.openView();
//           },
//           onChanged: (_) {
//             controller.openView();
//           },
//           leading: const Icon(Icons.search)),
//       suggestionsBuilder: (context, controller) {
//         return List<ListTile>.generate(5, (int index) {
//           final String item = 'item $index';
//           return ListTile(
//             title: Text(item),
//             onTap: () {
//               setState(() {
//                 controller.closeView(item);
//               });
//             },
//           );
//         });
//       },
//     );
//   }
// }
