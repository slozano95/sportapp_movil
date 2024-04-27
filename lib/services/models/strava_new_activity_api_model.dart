class StravaNewActivityApiModel {
  String id = "";
  String? name;
  String? sport_type;
  String? start_date_local;
  int? elapsed_time;

  StravaNewActivityApiModel(
      {this.name, this.sport_type, this.start_date_local, this.elapsed_time});

  factory StravaNewActivityApiModel.fromJson(Map<String, dynamic> json) =>
      StravaNewActivityApiModel(
          name: json["name"],
          sport_type: json["sport_type"],
          start_date_local: json["start_date_local"],
          elapsed_time: json["elapsed_time"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "sport_type": sport_type,
        "start_date_local": start_date_local,
        "elapsed_time": elapsed_time,
      };
}
