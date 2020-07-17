import 'package:firebase_auth/firebase_auth.dart';
import 'package:belajarflutter/models/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid:user.uid) : null;
  }

  //stream for authenticate user change
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }
  
  //sign in email dan password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up email and password
  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Forgot password
  Future forgotPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;
    }
  }

}
