import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'package:docs/constant.dart';
import 'package:docs/models/document_model.dart';
import 'package:docs/models/error_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:const_date_time/const_date_time.dart';

final DocRepoProvider = Provider<DocRepo>((ref) => DocRepo(client: Client()));

class DocRepo {
  final Client _client;

  DocRepo({required Client client}) : _client = client;

  Future<ErrorModel> CreateDoc(String token) async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      var res = await _client.post(Uri.parse('$host/doc/create'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          body:
              jsonEncode({'createdat': DateTime.now().microsecondsSinceEpoch}));

      switch (res.statusCode) {
        case 200:
          // final document = DocumentModel.fromJson(res.body);
          error =
              ErrorModel(error: null, data: DocumentModel.fromJson(res.body));
          break;

        default:
          error = ErrorModel(error: res.body, data: null);
          break;
      }
    } catch (e) {
      print("lglgbl");
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}
