import 'dart:html';

//import 'package:docs/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final AuthRepositoryprovider =
    //Provider(((ref) => AuthRepository(googlesignIn: GoogleSignIn(), client: null)));
    Provider(((ref) => AuthRepository(googlesignIn: GoogleSignIn())));

class AuthRepository {
  // final GoogleSignIn googlesignIn;
  final GoogleSignIn pgooglesignIn;
//  final Client _client;

  AuthRepository({
    // required this.googlesignIn
    //   required Client client,
    required GoogleSignIn googlesignIn,
  }) : pgooglesignIn = googlesignIn;
  //  _client = client      ;

  void signWithGoogle() async {
    try {
      final user = await pgooglesignIn.signIn();
      if (user != null) {
        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        print('  displayName-->${user.displayName}');
        print('          id--->${user.id}');
        print('     photoUrl--->${user.photoUrl}');
        print('        email--->${user.email}');
        print('serverAuthCode--->${user.serverAuthCode}');
        print('***************************************');

        // final userAcc = UserModel(
        //     email: user.email,
        //     name: user.displayName!,
        //     profilePic: user.photoUrl!,
        //     uid: '',
        //     token: '');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
