import 'dart:convert';
import 'dart:html';

import 'package:docs/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import '../constant.dart';
import '../models/user_model.dart';

final AuthRepositoryprovider = Provider(
    ((ref) => AuthRepository(googlesignIn: GoogleSignIn(), client: Client())));

// Provider(((ref) => AuthRepository(googlesignIn: GoogleSignIn())));

class AuthRepository {
  // final GoogleSignIn googlesignIn;
  final GoogleSignIn pgooglesignIn;
  final Client _client;

  AuthRepository({
    // required this.googlesignIn
    required Client client,
    required GoogleSignIn googlesignIn,
  })  : pgooglesignIn = googlesignIn,
        _client = client;

  void signWithGoogle() async {
    try {
      final user = await pgooglesignIn.signIn();
      if (user != null) {
        // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        // print('  displayName-->${user.displayName}');
        // print('          id--->${user.id}');
        // print('     photoUrl--->${user.photoUrl}');
        // print('        email--->${user.email}');
        // print('serverAuthCode--->${user.serverAuthCode}');
        // print('***************************************');

        final userAcc = UserModel(
            email: user.email,
            name: user.displayName!,
            profilePic: user.photoUrl!,
            uid: '',
            token: '');

        var res = await _client.post(Uri.parse('${host}/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
          // error = ErrorModel(error: null, data: newUser);
          // _localStorageRepository.setToken(newUser.token);
          // break;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
