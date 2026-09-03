// ignore_for_file: dead_null_aware_expression, unnecessary_null_comparison, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/api/movie.dart';

class HistoryFirestore {
  static CollectionReference<Map<String, dynamic>> historyCollection() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not logged in ");
    }
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("history");
  }

  static Future<void> addToHistory(Movie movie) async {
    if (movie.id == null) {
      throw Exception("Movie id is null");
    }

    await historyCollection().doc(movie.id.toString()).set({
      "id": movie.id,
      "rating": movie.rating ?? 0,
      "poster": movie.mediumCoverImage ?? movie.largeCoverImage ?? "",
      "watchedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> historyStream() {
    return historyCollection()
        .orderBy("watchedAt", descending: true)
        .snapshots();
  }

  static Stream<int> historyCountStream() {
    return historyStream().map((snapshot) => snapshot.docs.length);
  }

  static Future<void> deleteFromHstory(int movieId) async {
    await historyCollection().doc(movieId.toString()).delete();
  }

  static Future<bool> isMoveiInHistory(int movieId) async {
    final doc = await historyCollection().doc(movieId.toString()).get();
    return doc.exists;
  }
}
