import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtil {
  late final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  String? _deviceName;

  Future<String?> getDeviceName() async {
    if (_deviceName != null) {
      return _deviceName;
    }

    switch (Platform.operatingSystem) {
      case 'android':
        final androidInfo = await _deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
        break;
      case 'ios':
        final iosInfo = await _deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine;
        break;
      case 'windows':
        _deviceName = 'Windows';
        break;
      case 'macos':
        _deviceName = 'macOS';
        break;
      case 'linux':
        _deviceName = 'Linux';
        break;
      default:
        _deviceName = 'Unknown Platform';
        break;
    }

    return _deviceName;
  }
}
