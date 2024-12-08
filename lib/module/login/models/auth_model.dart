class AuthModel {
  String? accessToken;
  String? tokenType;
  DateTime? expiresIn;

  AuthModel({
    this.accessToken,
    this.expiresIn,
    this.tokenType,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = DateTime.now().add(
      Duration(
        seconds: (json['expires_in']),
      ),
    );
  }
}
