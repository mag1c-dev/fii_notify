import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceUtils {
  static Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getDeviceInfo() async {
    var st = '';
    if (Platform.isAndroid) {
      final info = await PlatformDeviceId.deviceInfoPlugin.androidInfo;
      st =
          '${Platform.operatingSystem} (${info.brand} ${info.model}, ${Platform.operatingSystem} ${info.version.release})';
    } else {
      final info = await PlatformDeviceId.deviceInfoPlugin.iosInfo;
      st =
          '${Platform.operatingSystem} (${info.model} ${info.name}, ${info.systemName} ${info.systemVersion})';
    }
    return st;
  }

  static Future<String> getLocalIpAddress() async {
    final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4, includeLinkLocal: true);

    try {
      // Try VPN connection first
      final vpnInterface =
          interfaces.firstWhere((element) => element.name == 'tun0');
      return vpnInterface.addresses.first.address;
    } catch (e) {
      if (e is StateError) {
        try {
          final interface =
              interfaces.firstWhere((element) => element.name == 'wlan0');
          return interface.addresses.first.address;
        } catch (ex) {
          // Try any other connection next
          try {
            final interface = interfaces.firstWhere((element) =>
                !(element.name == 'tun0' || element.name == 'wlan0'));
            return interface.addresses.first.address;
          } catch (ex) {
            return '';
          }
        }
      }
      return '';
    }
  }
}
