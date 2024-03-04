class ReportedUser {
  String? id;
  String? reportingUserId;
  String? reportedUserId;
  String? reason;
  DateTime? reportedAt;

  ReportedUser({
    this.id,
    this.reportedUserId,
    this.reportedAt,
    this.reportingUserId,
    this.reason,
  });

  ReportedUser.fromJson(json, id) {
    this.id = id;
    this.reason = json["reason"];
    this.reportingUserId = json["reportingUserId"] ?? '';
    this.reportedUserId = json["reportedUserId"] ?? '';
    this.reportedAt = json["reportedAt"].toDate() ?? DateTime.now();
  }

  toJson() {
    return {
      "reportingUserId": this.reportingUserId,
      "reportedUserId": this.reportedUserId,
      "reportedAt": this.reportedAt,
      "reason": this.reason,
    };
  }
}
