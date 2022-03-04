import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      await _fireStore
          .collection("Trainers")
          .doc(googleSignInAccount.email)
          .set({
        'userName': googleSignInAccount.displayName,
        'email': googleSignInAccount.email,
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required email, required password}) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword(
      {required email, required password}) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signInWithFacebook() async {
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      //FacebookPermission.userFriends,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        final result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        // final profile = await fb.getUserProfile();
        // final email = await fb.getUserEmail();

        final kCurrentUser = _auth.currentUser;
        await _fireStore.collection("Trainers").doc(kCurrentUser?.email).set({
          'userName': kCurrentUser?.displayName,
          'email': kCurrentUser?.email,
        });
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        debugPrint('Error while log in: ${res.error}');
        break;
    }
  }

  Future<void> signOutFromFirebase() async {
    _googleSignIn.signOut();
    _auth.signOut();
    fb.logOut();
  }
}
