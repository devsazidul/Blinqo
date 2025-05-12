class LoginModel {
  LoginModel({required this.accessToken, required this.user});

  final String? accessToken;
  final User? user;

  LoginModel copyWith({String? accessToken, User? user}) {
    return LoginModel(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["access_token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user": user?.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.roles,
    required this.isVerified,
    required this.profileId,
    required this.isProfileCreated,
  });

  final String? id;
  final String? email;
  final List<String> roles;
  final bool? isVerified;
  final String? profileId;
  final bool? isProfileCreated;

  User copyWith({
    String? id,
    String? email,
    List<String>? roles,
    bool? isVerified,
    String? profileId,
    bool? isProfileCreated,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      isVerified: isVerified ?? this.isVerified,
      profileId: profileId ?? this.profileId,
      isProfileCreated: isProfileCreated ?? this.isProfileCreated,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      roles:
          json["roles"] == null
              ? []
              : List<String>.from(json["roles"]!.map((x) => x)),
      isVerified: json["isVerified"],
      profileId: json["profileId"],
      isProfileCreated: json["isProfileCreated"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "roles": roles.map((x) => x).toList(),
    "isVerified": isVerified,
    "profileId": profileId,
    "isProfileCreated": isProfileCreated,
  };
}

/*
{
	"access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MTQ0MTg2Yy1iNDVjLTQwMmYtODhjZC0zZGE5NjNiZDdmZmUiLCJlbWFpbCI6InRlc3QxQHlvcG1haWwuY29tIiwicm9sZSI6WyJTRVJWSUNFX1BST1ZJREVSIl0sImlzVmVyaWZpZWQiOnRydWUsInByb2ZpbGVJZCI6IiIsImlhdCI6MTc0NzA0MDEwMiwiZXhwIjoxNzQ3NjQ0OTAyfQ.sFRmsWUUkEZ1PYfZFdAApsvqzQjBEnamAhG6A5NWexM",
	"user": {
		"id": "4144186c-b45c-402f-88cd-3da963bd7ffe",
		"email": "test1@yopmail.com",
		"roles": [
			"SERVICE_PROVIDER"
		],
		"isVerified": true,
		"profileId": "",
		"isProfileCreated": false
	}
}*/
