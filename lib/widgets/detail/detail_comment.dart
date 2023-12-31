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
  late int editNum;
  late bool isEditting = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    TextEditingController commentEditingController = TextEditingController();

    final db = FirebaseFirestore.instance;
    var movieComment = <String, dynamic>{
      "movie_id": widget.movieId,
      "user_email": "jspark9703@naver.com",
      "comment": "this is interesting",
    };

    return Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                appState.loggedIn
                    ? appState.emailVerified
                        ? TextField(
                            controller: textEditingController,
                            maxLines: 1,
                            decoration:
                                const InputDecoration(hintText: "댓글을 작성하세요!"),
                            onSubmitted: (value) {
                              setState(() {
                                movieComment = <String, dynamic>{
                                  "movie_id": widget.movieId,
                                  "user_email": appState.userEmail,
                                  "comment": value,
                                };
                              });
                              db
                                  .collection("movieComment")
                                  .add(movieComment)
                                  .then((DocumentReference doc) => print(
                                      'DocumentSnapshot added with ID: ${doc.id}'));
                            },
                          )
                        : const Center(child: Text("이메일 인증을하여 댓글을 달아보세요"))
                    : const Center(child: Text("로그인하여 댓글을 달아보세요.")),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: FutureBuilder<QuerySnapshot>(
                    future: db
                        .collection("movieComment")
                        .where("movie_id", isEqualTo: widget.movieId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Display a loading indicator while fetching data.
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No comments available.');
                      }

                      // Replace 1 with the actual number of comments you want to display.
                      int itemCount = snapshot.data!.size;

                      return ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          String comment = data["comment"];
                          String user = data["user_email"];
                          return ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: Text(user),
                              title: isEditting && editNum == index
                                  ? TextField(
                                      controller: commentEditingController,
                                      autofocus: true,
                                      maxLines: 1,
                                      onSubmitted: (value) {
                                        db
                                            .collection("movieComment")
                                            .doc(data.id)
                                            .set({
                                          "comment": value,
                                        }, SetOptions(merge: true)).then(
                                                (value) => setState(() {
                                                      isEditting = false;
                                                    }));
                                      },
                                    )
                                  : Text(comment),
                              trailing: appState.userEmail == user
                                  ? SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  editNum = index;
                                                  isEditting = true;
                                                });
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                                db
                                                    .collection("movieComment")
                                                    .doc(data.id)
                                                    .delete()
                                                    .then((value) =>
                                                        setState(() {}));
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    )
                                  : null);
                        },
                      );
                    },
                  ),
                )
              ],
            ));
  }
}
