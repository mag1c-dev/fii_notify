import 'dart:convert';

import 'package:fresh_dio/fresh_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/data/models/token_model.dart';

class TokenPreferencesStorage implements TokenStorage<TokenModel> {
  TokenPreferencesStorage();

  static const tokenStoreKey = '__token_store_key__';

  @override
  Future<void> delete() async {
    return SharedPreferences.getInstance().then((value) {
      value.remove(tokenStoreKey);
    });
  }

  @override
  Future<TokenModel?> read() {
    return SharedPreferences.getInstance().then((value) {
      try {
        return TokenModel.fromJson(
          json.decode(value.getString(tokenStoreKey)!) as Map<String, dynamic>,
        );
      } catch (e) {
        delete();
      }
      return null;
    });
  }

  @override
  Future<void> write(TokenModel token) async {
    return SharedPreferences.getInstance().then((value) {
      value.setString(tokenStoreKey, jsonEncode(token.toJson()));
    });
  }
}
