import 'package:assessment_app/flavors/flavor_config.dart';
import 'package:assessment_app/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.WIRE,
    env: "WIRE",
    name: "The Wire Character Viewer",
    values: FlavorValues(
        bundleID: 'com.sample.wireviewer',
        dataAPI: 'http://api.duckduckgo.com/?q=the+wire+characters&format=json',
        baseURL: 'https://duckduckgo.com/'),
  );

  mainCommon();
}
