import 'package:flutter_test/flutter_test.dart';
import 'package:journey_sharing_application/destination-location-map.dart';

main() {
  test("gender preference everyone", (){
    DestinationMapWidgetState.setGenderPreference("everyone");
    bool flag = DestinationMapWidgetState.isGenderPreference("everyone");
    expect(flag, true);
  });

  test("gender preference male", (){
    DestinationMapWidgetState.setGenderPreference("male");
    bool flag = DestinationMapWidgetState.isGenderPreference("male");
    expect(flag, true);
  });

  test("gender preference female", () {
    DestinationMapWidgetState.setGenderPreference("male");
    bool flag = DestinationMapWidgetState.isGenderPreference("male");
    expect(flag, true);
  });

  test("gender preference random", () {
    DestinationMapWidgetState.setGenderPreference("random");
    bool flag = DestinationMapWidgetState.isGenderPreference("everyone");
    expect(flag, true);
  });

}