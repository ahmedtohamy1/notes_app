// // import 'package:flutter/material.dart';
// // import 'package:noty/models/note_model.dart';
// // import 'package:noty/screens/tile_screen.dart';

// // class NoteTiles extends StatelessWidget {
// //   const NoteTiles({super.key, required this.notesList});
// //   final List<NoteModel> notesList;

// //   @override
// //   Widget build(BuildContext context) {
// //     return GridView.builder(
// //       physics: const BouncingScrollPhysics(),
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         crossAxisSpacing: 0.01,
// //         mainAxisSpacing: 0.01,
// //       ),
// //       itemCount: notesList.length,
// //       itemBuilder: (context, index) {
// //         final note = notesList[index];
// //         return GestureDetector(
// //           onTap: () {
// //             Navigator.of(context).push(
// //                 MaterialPageRoute(builder: (context) => TileScreen(note.id)));
// //           },
// //           child: ListTile(
// //             title: Container(
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(12),
// //                 color: Theme.of(context).colorScheme.surfaceVariant,
// //               ),
// //               child: Text(
// //                 note.text,
// //                 maxLines: 15,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: TextStyle(
// //                   color: Theme.of(context).colorScheme.onSurfaceVariant,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:noty/models/note_model.dart';
// import 'package:noty/screens/tile_screen.dart';

// class NoteTiles extends StatelessWidget {
//   const NoteTiles({super.key, required this.notesList});
//   final List<NoteModel> notesList;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const BouncingScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: notesList.length,
//       itemBuilder: (context, index) {
//         final note = notesList[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => TileScreen(note.id)));
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             elevation: 5,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.deepPurple.withOpacity(0.7),
//                         Colors.blue.withOpacity(0.7)
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           note.text,
//                           maxLines: 6,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           'Location: ${note.location}', // Assuming 'location' field exists
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.8),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:noty/models/note_model.dart';
import 'package:noty/screens/tile_screen.dart';

class NoteTiles extends StatelessWidget {
  const NoteTiles({Key? key, required this.notesList}) : super(key: key);

  final List<NoteModel> notesList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        final note = notesList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TileScreen(note.id)),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withOpacity(0.8),
                        Colors.blue.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RichText(
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: note.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Location: ${note.location}', // Assuming 'location' field exists
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
