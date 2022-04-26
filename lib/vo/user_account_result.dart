import 'package:json_annotation/json_annotation.dart';

import '../model/local_user.dart';

part 'user_account_result.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAccountResult {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  @JsonKey(name: 'token_type')
  String tokenType;
  String scope;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  LocalUser user;

  UserAccountResult(
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.scope,
    this.refreshToken,
    this.user,
  );

  factory UserAccountResult.fromJson(Map<String, dynamic> json) => _$UserAccountResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountResultToJson(this);

  @override
  String toString() {
    return 'UserAccount{accessToken: $accessToken, expiresIn: $expiresIn, tokenType: $tokenType, scope: $scope, refreshToken: $refreshToken, user: $user}';
  }
}
