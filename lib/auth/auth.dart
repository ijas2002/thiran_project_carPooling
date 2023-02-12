import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance.collection("users");

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
  {required String email,required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
  }
  Future<void> createUserWithEmailAndPassword(
      {required String email,required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
  }
  Future<void> sendResetPasswordEmail(
      {required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }


  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<void> saveDataToFirestoreDB({
    required String name, required int id,
    required String source, required String destination,
    required int apxAmount,required int contactNo,
    required String gender,required int vacancySeat}) async {
    await _database.add({
      "name": name,
      "id":id,
      "source":source,
      "destination":destination,
      "apxAmount":apxAmount,
      "contactNo":contactNo,
      "gender":gender,
      "vacancySeat":vacancySeat

    });
  }

}