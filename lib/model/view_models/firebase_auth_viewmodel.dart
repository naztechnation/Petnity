import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class FirebaseAuthProvider extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Status _status = Status.uninitialized;

  Status get status => _status;

  setBack() {
    _status = Status.authenticated;
    setViewState(ViewState.success);
  }

  Future<bool> isLoggedIn() async {
    //  bool isLoggedIn = await googleSignIn.isSignedIn();
    //  if (isLoggedIn &&
    //      prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
    //    return true;
    //  } else {
    //    return false;
    //  }

    return true;
  }

  Future<void> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    _status = Status.authenticating;
    setViewState(ViewState.success);

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_firebaseAuth.currentUser!.uid != null) {
        await _firebaseStorage
            .collection('users')
            .doc(_firebaseAuth.currentUser!.uid)
            .set({
          'chattingWith': null,
          'uid': _firebaseAuth.currentUser!.uid,
          'userName': username,
          'userEmail': email,
          'pushToken': '',
          'online': false,
        });

        _status = Status.authenticated;
        setViewState(ViewState.success);
      }
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError;
      setViewState(ViewState.success);

      ;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _status = Status.authenticating;
    setViewState(ViewState.success);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      _status = Status.authenticated;
      setViewState(ViewState.success);
      return user;
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError;
      setViewState(ViewState.success);

      return null;
    }
  }


}
