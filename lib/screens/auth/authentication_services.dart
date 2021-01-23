import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Add user to DB
  Future<void> addUserToDB({
    String uid,
    String namalengkap,
    String email,
    String password,
  }) async {
    userModel = UserModel(
      uid: uid,
      namalengkap: namalengkap,
      email: email,
      password: password,
    );

    await userRef.doc(uid).set(userModel.toMap(userModel));
  }

}


  
class UserModel {
  String uid;
  String namalengkap;
  String email;
  String password;

  UserModel({
    this.uid,
    this.namalengkap,
    this.email,
    this.password,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["namalengkap"] = user.namalengkap;
    data["email"] = user.email;
    data["password"] = user.password;

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.namalengkap = mapData["namalengkap"];
    this.email = mapData["email"];
  }
}