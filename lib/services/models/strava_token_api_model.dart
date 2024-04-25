class StravaTokenApiModel {
  String? tokenType;
  int? expiresAt;
  int? expiresIn;
  String? refreshToken;
  String? accessToken;
  Athlete? athlete;

  StravaTokenApiModel({
    this.tokenType,
    this.expiresAt,
    this.expiresIn,
    this.refreshToken,
    this.accessToken,
    this.athlete,
  });

  factory StravaTokenApiModel.fromJson(Map<String, dynamic> json) =>
      StravaTokenApiModel(
        tokenType: json["token_type"],
        expiresAt: json["expires_at"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
        athlete:
            json["athlete"] == null ? null : Athlete.fromJson(json["athlete"]),
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_at": expiresAt,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "athlete": athlete?.toJson(),
      };
}

class Athlete {
  int? id;
  dynamic username;
  int? resourceState;
  String? firstname;
  String? lastname;
  dynamic bio;
  dynamic city;
  dynamic state;
  dynamic country;
  String? sex;
  bool? premium;
  bool? summit;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? badgeTypeId;
  dynamic weight;
  String? profileMedium;
  String? profile;
  dynamic friend;
  dynamic follower;

  Athlete({
    this.id,
    this.username,
    this.resourceState,
    this.firstname,
    this.lastname,
    this.bio,
    this.city,
    this.state,
    this.country,
    this.sex,
    this.premium,
    this.summit,
    this.createdAt,
    this.updatedAt,
    this.badgeTypeId,
    this.weight,
    this.profileMedium,
    this.profile,
    this.friend,
    this.follower,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) => Athlete(
        id: json["id"],
        username: json["username"],
        resourceState: json["resource_state"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        bio: json["bio"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        sex: json["sex"],
        premium: json["premium"],
        summit: json["summit"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        badgeTypeId: json["badge_type_id"],
        weight: json["weight"],
        profileMedium: json["profile_medium"],
        profile: json["profile"],
        friend: json["friend"],
        follower: json["follower"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "resource_state": resourceState,
        "firstname": firstname,
        "lastname": lastname,
        "bio": bio,
        "city": city,
        "state": state,
        "country": country,
        "sex": sex,
        "premium": premium,
        "summit": summit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "badge_type_id": badgeTypeId,
        "weight": weight,
        "profile_medium": profileMedium,
        "profile": profile,
        "friend": friend,
        "follower": follower,
      };
}
