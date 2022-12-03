import 'dart:convert';
import 'package:docs/models/error_model.dart';
import 'package:docs/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import '../constant.dart';
import 'local_storage_repository.dart';

//final AuthRepositoryprovider = Provider<AuthRepository>(((ref) => AuthRepository(
final AuthRepositoryprovider = Provider(((ref) => AuthRepository(
    googlesignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepository: LocalStorageRepository())));

// Provider(((ref) => AuthRepository(googlesignIn: GoogleSignIn())));

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  // final GoogleSignIn googlesignIn;
  final GoogleSignIn pgooglesignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository({
    // required this.googlesignIn
    required Client client,
    required GoogleSignIn googlesignIn,
    required LocalStorageRepository localStorageRepository,
  })  : pgooglesignIn = googlesignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signWithGoole() async {
    ErrorModel error =
        ErrorModel(error: "something unexpected occured :)", data: null);

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
            name: user.displayName! ?? '',
            profilePic: user.photoUrl ?? '',
            uid: '',
            token: '');

        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
              "Access-Control_Allow_Origin": "*"
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );

            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        error = ErrorModel(error: e.toString(), data: null);
        print(e);
      }
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      String? token = await _localStorageRepository.getToken();

      if (token != null) {
        var res = await _client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        switch (res.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)['user'],
              ),
            ).copyWith(token: token);
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  // void signOut() async {
  //   await _googleSignIn.signOut();
  //   _localStorageRepository.setToken('');
  // }

}
//https://twitter.com/i/status/1562294013591371777