// import 'package:assessment_app/';

import 'package:assessment_app/flavors/flavor_config.dart';
import 'package:assessment_app/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.SIMPSON,
    env: "SIMPSON",
    name: "Simpsons Character Viewer",
    values: FlavorValues(
        bundleID: 'com.sample.simpsonsviewer',
        dataAPI: 'http://api.duckduckgo.com/?q=simpsons+characters&format=json',
        baseURL: 'https://duckduckgo.com/'),
  );

  mainCommon();
}
