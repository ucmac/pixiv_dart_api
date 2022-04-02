import 'package:json_annotation/json_annotation.dart';

import '../entity/local_user.dart';

part 'user_account.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAccount {
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

  UserAccount(
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.scope,
    this.refreshToken,
    this.user,
  );

  factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);

  @override
  String toString() {
    return 'UserAccount{accessToken: $accessToken, expiresIn: $expiresIn, tokenType: $tokenType, scope: $scope, refreshToken: $refreshToken, user: $user}';
  }
}
