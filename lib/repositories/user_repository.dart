
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn}):
      _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );
    await _firebaseAuth.signInWithCredential(authCredential);
  }
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim());
  }
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password);
  }
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }
  Future<bool> isSignedIn() async {
    return await _firebaseAuth.currentUser() != null;
  }
  Future<FirebaseUser> getUser() async{
    return await _firebaseAuth.currentUser();
  }
}