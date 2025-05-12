class SignUpModel {
  SignUpModel({required this.accessToken, required this.user});

  final String? accessToken;
  final User? user;

  SignUpModel copyWith({String? accessToken, User? user}) {
    return SignUpModel(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
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
    required this.role,
    required this.isVerified,
    required this.profileId,
  });

  final String? id;
  final String? email;
  final List<String> role;
  final bool? isVerified;
  final String? profileId;

  User copyWith({
    String? id,
    String? email,
    List<String>? role,
    bool? isVerified,
    String? profileId,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      profileId: profileId ?? this.profileId,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      role:
          json["role"] == null
              ? []
              : List<String>.from(json["role"]!.map((x) => x)),
      isVerified: json["isVerified"],
      profileId: json["profileId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role.map((x) => x).toList(),
    "isVerified": isVerified,
    "profileId": profileId,
  };
}

/*
{
	"access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MTQ0MTg2Yy1iNDVjLTQwMmYtODhjZC0zZGE5NjNiZDdmZmUiLCJlbWFpbCI6InRlc3QxQHlvcG1haWwuY29tIiwicm9sZSI6WyJTRVJWSUNFX1BST1ZJREVSIl0sImlzVmVyaWZpZWQiOmZhbHNlLCJwcm9maWxlSWQiOiIiLCJpYXQiOjE3NDcwMzk3NjYsImV4cCI6MTc0NzY0NDU2Nn0.zTCEE9Df5c1s1Z4_ZdgTvofQ9g2P0u5xHHLacFZSnBw",
	"user": {
		"id": "4144186c-b45c-402f-88cd-3da963bd7ffe",
		"email": "test1@yopmail.com",
		"role": [
			"SERVICE_PROVIDER"
		],
		"isVerified": false,
		"profileId": ""
	}
}*/
