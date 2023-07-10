import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mallu_calls/screen/home/view/home_view.dart';
import 'package:mallu_calls/util/popup.dart';
import 'package:mallu_calls/util/routes.dart';
import 'package:mallu_calls/util/server.dart';
import 'package:mallu_calls/util/url.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  LoginProvider(this._auth);
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  bool googleProgress = false;

  Future<void> signInWithGoogle() async {
    googleProgress = true;
    notifyListeners();
    try {
      bool isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) await GoogleSignIn().signOut();
      GoogleSignInAccount? result = await GoogleSignIn().signIn();
      if (result == null) {
        PopUp.show(message: 'Login Failed', type: PopUpType.error);
        googleProgress = false;
        notifyListeners();
      } else {
        GoogleSignInAuthentication cred = await result.authentication;
        UserCredential userPro = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: cred.accessToken,
            idToken: cred.idToken,
          ),
        );
        if (userPro.user == null) {
          googleProgress = false;
          notifyListeners();
        } else {
          if (userPro.additionalUserInfo!.isNewUser) {
            log("User Registered in with Google ${userPro.user!.uid}");
            Map<String, dynamic> data = {
              "userName": userPro.user!.displayName.toString(),
              "userMail": userPro.user!.email.toString(),
              "userUid": userPro.user!.uid.toString(),
              "userImage": userPro.user!.photoURL.toString(),
            };
            List response = await Server.post(Urls.signUp, data: data);
            if (kDebugMode) {
              print("User Registered in with Google $response");
            }
            if (response.first >= 200 && response.first < 300) {
              await _storage.write(key: 'login', value: 'true');
              await _storage.write(key: 'token', value: response[1]['token']);
              Routes.pushRemoveUntil(screen: const HomeView());
              googleProgress = false;
              notifyListeners();
            } else {
              PopUp.show(
                message: response.last.toString(),
                type: PopUpType.error,
              );
              googleProgress = false;
              notifyListeners();
            }
            googleProgress = false;
            notifyListeners();
          } else {
            List response = await Server.get(
              Urls.login + userPro.user!.uid.toString(),
            );
            if (kDebugMode) {
              print(
                  "User Logged in with Google ${response.last} ${response.first}");
            }
            if (response.first >= 200 && response.first < 300) {
              await _storage.write(key: 'login', value: 'true');
              await _storage.write(key: 'token', value: response[1]['token']);
              googleProgress = false;
              notifyListeners();
              Routes.pushRemoveUntil(screen: const HomeView());
            } else {
              log(response.last.toString());
              PopUp.show(message: 'Login Failed', type: PopUpType.error);
              googleProgress = false;
              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
      googleProgress = false;
      notifyListeners();
      PopUp.show(message: 'Try again network error', type: PopUpType.error);
      if (kDebugMode) {
        print("User Logged in with Google $e");
      }
    }
  }
}
