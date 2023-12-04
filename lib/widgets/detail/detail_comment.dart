import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/firebase.dart';
import 'package:provider/provider.dart';

class DetailComment extends StatefulWidget {
  const DetailComment({super.key, required this.movieId});
  final String movieId;
  @override
  State<DetailComment> createState() => _DetailCommentState();
}

class _DetailCommentState extends State<DetailComment> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    final db = FirebaseFirestore.instance;
    final movieComment = <String, dynamic>{
      "movie_id": widget.movieId,
      "user_imail": "jspark9703@naver.com",
      "comment": "this is interesting",
      "score": 10,
    };

    return Consumer<ApplicationState>(
        builder: (context, appState, _) => appState.loggedIn
            ? appState.emailVerified
                ? Column(
                    children: [
                      TextField(
                        controller: textEditingController,
                        maxLines: 1,
                        onSubmitted: (value) {
                          db.collection("movieComment").add(movieComment).then(
                              (DocumentReference doc) => print(
                                  'DocumentSnapshot added with ID: ${doc.id}'));
                        },
                      ),
                      const SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          child: Column(children: []),
                        ),
                      )
                    ],
                  )
                : const Center(child: Text("이메일 인증하여 댓글을 달아보세요"))
            : const Center(
                child: Text("로그인하여 댓글을 달아보세요"),
              ));
  }
}
