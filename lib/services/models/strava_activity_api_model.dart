class StravaActivityApiModel {
  int? resourceState;
  AAthlete? athlete;
  String? name;
  int? distance;
  int? movingTime;
  int? elapsedTime;
  int? totalElevationGain;
  String? type;
  String? sportType;
  dynamic workoutType;
  int? id;
  DateTime? startDate;
  DateTime? startDateLocal;
  String? timezone;
  int? utcOffset;
  dynamic locationCity;
  dynamic locationState;
  dynamic locationCountry;
  int? achievementCount;
  int? kudosCount;
  int? commentCount;
  int? athleteCount;
  int? photoCount;
  MapClass? map;
  bool? trainer;
  bool? commute;
  bool? manual;
  bool? private;
  String? visibility;
  bool? flagged;
  dynamic gearId;
  List<dynamic>? startLatlng;
  List<dynamic>? endLatlng;
  double? averageSpeed;
  int? maxSpeed;
  bool? hasHeartrate;
  bool? heartrateOptOut;
  bool? displayHideHeartrateOption;
  dynamic uploadId;
  dynamic externalId;
  bool? fromAcceptedTag;
  int? prCount;
  int? totalPhotoCount;
  bool? hasKudoed;

  StravaActivityApiModel({
    this.resourceState,
    this.athlete,
    this.name,
    this.distance,
    this.movingTime,
    this.elapsedTime,
    this.totalElevationGain,
    this.type,
    this.sportType,
    this.workoutType,
    this.id,
    this.startDate,
    this.startDateLocal,
    this.timezone,
    this.utcOffset,
    this.locationCity,
    this.locationState,
    this.locationCountry,
    this.achievementCount,
    this.kudosCount,
    this.commentCount,
    this.athleteCount,
    this.photoCount,
    this.map,
    this.trainer,
    this.commute,
    this.manual,
    this.private,
    this.visibility,
    this.flagged,
    this.gearId,
    this.startLatlng,
    this.endLatlng,
    this.averageSpeed,
    this.maxSpeed,
    this.hasHeartrate,
    this.heartrateOptOut,
    this.displayHideHeartrateOption,
    this.uploadId,
    this.externalId,
    this.fromAcceptedTag,
    this.prCount,
    this.totalPhotoCount,
    this.hasKudoed,
  });

  factory StravaActivityApiModel.fromJson(Map<String, dynamic> json) =>
      StravaActivityApiModel(
        resourceState: json["resource_state"],
        athlete:
            json["athlete"] == null ? null : AAthlete.fromJson(json["athlete"]),
        name: json["name"],
        distance: json["distance"],
        movingTime: json["moving_time"],
        elapsedTime: json["elapsed_time"],
        totalElevationGain: json["total_elevation_gain"],
        type: json["type"],
        sportType: json["sport_type"],
        workoutType: json["workout_type"],
        id: json["id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        startDateLocal: json["start_date_local"] == null
            ? null
            : DateTime.parse(json["start_date_local"]),
        timezone: json["timezone"],
        utcOffset: json["utc_offset"],
        locationCity: json["location_city"],
        locationState: json["location_state"],
        locationCountry: json["location_country"],
        achievementCount: json["achievement_count"],
        kudosCount: json["kudos_count"],
        commentCount: json["comment_count"],
        athleteCount: json["athlete_count"],
        photoCount: json["photo_count"],
        map: json["map"] == null ? null : MapClass.fromJson(json["map"]),
        trainer: json["trainer"],
        commute: json["commute"],
        manual: json["manual"],
        private: json["private"],
        visibility: json["visibility"],
        flagged: json["flagged"],
        gearId: json["gear_id"],
        startLatlng: json["start_latlng"] == null
            ? []
            : List<dynamic>.from(json["start_latlng"]!.map((x) => x)),
        endLatlng: json["end_latlng"] == null
            ? []
            : List<dynamic>.from(json["end_latlng"]!.map((x) => x)),
        averageSpeed: json["average_speed"]?.toDouble(),
        maxSpeed: json["max_speed"],
        hasHeartrate: json["has_heartrate"],
        heartrateOptOut: json["heartrate_opt_out"],
        displayHideHeartrateOption: json["display_hide_heartrate_option"],
        uploadId: json["upload_id"],
        externalId: json["external_id"],
        fromAcceptedTag: json["from_accepted_tag"],
        prCount: json["pr_count"],
        totalPhotoCount: json["total_photo_count"],
        hasKudoed: json["has_kudoed"],
      );

  Map<String, dynamic> toJson() => {
        "resource_state": resourceState,
        "athlete": athlete?.toJson(),
        "name": name,
        "distance": distance,
        "moving_time": movingTime,
        "elapsed_time": elapsedTime,
        "total_elevation_gain": totalElevationGain,
        "type": type,
        "sport_type": sportType,
        "workout_type": workoutType,
        "id": id,
        "start_date": startDate?.toIso8601String(),
        "start_date_local": startDateLocal?.toIso8601String(),
        "timezone": timezone,
        "utc_offset": utcOffset,
        "location_city": locationCity,
        "location_state": locationState,
        "location_country": locationCountry,
        "achievement_count": achievementCount,
        "kudos_count": kudosCount,
        "comment_count": commentCount,
        "athlete_count": athleteCount,
        "photo_count": photoCount,
        "map": map?.toJson(),
        "trainer": trainer,
        "commute": commute,
        "manual": manual,
        "private": private,
        "visibility": visibility,
        "flagged": flagged,
        "gear_id": gearId,
        "start_latlng": startLatlng == null
            ? []
            : List<dynamic>.from(startLatlng!.map((x) => x)),
        "end_latlng": endLatlng == null
            ? []
            : List<dynamic>.from(endLatlng!.map((x) => x)),
        "average_speed": averageSpeed,
        "max_speed": maxSpeed,
        "has_heartrate": hasHeartrate,
        "heartrate_opt_out": heartrateOptOut,
        "display_hide_heartrate_option": displayHideHeartrateOption,
        "upload_id": uploadId,
        "external_id": externalId,
        "from_accepted_tag": fromAcceptedTag,
        "pr_count": prCount,
        "total_photo_count": totalPhotoCount,
        "has_kudoed": hasKudoed,
      };
}

class AAthlete {
  int? id;
  int? resourceState;

  AAthlete({
    this.id,
    this.resourceState,
  });

  factory AAthlete.fromJson(Map<String, dynamic> json) => AAthlete(
        id: json["id"],
        resourceState: json["resource_state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resource_state": resourceState,
      };
}

class MapClass {
  String? id;
  String? summaryPolyline;
  int? resourceState;

  MapClass({
    this.id,
    this.summaryPolyline,
    this.resourceState,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
        id: json["id"],
        summaryPolyline: json["summary_polyline"],
        resourceState: json["resource_state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "summary_polyline": summaryPolyline,
        "resource_state": resourceState,
      };
}
