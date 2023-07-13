class Mandate {
  final int mandateId;
  final String dataSource;

  Map<String, dynamic> toJson() => {
    "mandateId": mandateId,
    "dataSource": dataSource
  };

  Mandate(this.mandateId, this.dataSource);
}
