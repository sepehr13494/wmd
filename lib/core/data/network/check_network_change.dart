import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/core/util/local_storage.dart';

class NetWorkChange{
  final LocalStorage localStorage;

  NetWorkChange(this.localStorage);

  Future<bool> checkNetworkChange() async{
    final hasVpn = await CheckVpnConnection.isVpnActive();
    final ipv4 = await Ipify.ipv4();
    print("ipv4"); // 98.207.254.136
    print(ipv4); // 98.207.254.136

    final lastIp = localStorage.getLastIp();
    localStorage.setLastIp(ipv4);
    return hasVpn && (lastIp != ipv4);
  }
}