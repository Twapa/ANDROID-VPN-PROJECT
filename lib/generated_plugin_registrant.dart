

/// ignore_for_file: directives_ordering
/// ignore_for_file: lines_longer_than_80_chars

import 'package:network_info_plus_web/network_info_plus_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  NetworkInfoPlusPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
