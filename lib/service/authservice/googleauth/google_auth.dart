import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/routes/routes.dart';

class GoogleAuth {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  // dont't gorget to add firebasea auth and google sign in package
  signInWithGoogle() async {
  try {
    print("HERE::::::::::::::::::");
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Print Google SignIn info for debugging
      print("Google Account: ${googleSignInAccount.email}");
      print("Access Token: ${googleSignInAuthentication.accessToken}");
      print("ID Token: ${googleSignInAuthentication.idToken}");

      await auth.signInWithCredential(authCredential);
      Get.offNamed(AppRoutes.Hotelid);
      print("User signed in successfully");
    } else {
      print("Google sign-in cancelled");
    }
  } on FirebaseAuthException catch (e) {
    print("FirebaseAuthException: ${e.message}");
  } catch (e) {
    print("Error during Google sign-in: ${e.toString()}");
  }
}


// for sign out
  googleSignOut() async {
    await googleSignIn.signOut();
    auth.signOut();
  }
}
// now we call this firebase services in our coninue with google button