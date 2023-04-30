class IsSafeDeviceResponse {
  final bool isSafe;
  final bool isIOS;
  final bool isAndroid;
  IsSafeDeviceResponse(this.isSafe,
      {this.isIOS = false, this.isAndroid = false});

  static final tResponse = IsSafeDeviceResponse(true);
}
