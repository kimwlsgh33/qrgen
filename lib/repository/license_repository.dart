//==============================================================================
// api
//==============================================================================
import 'dart:async';

class LicenseRepository {
  // make stream
  // broadcast: 여러개의 listener가 동시에 listen 할 수 있도록
  StreamController<bool> changeLicenseStatus =
      StreamController<bool>.broadcast();

  // license status stream
  late Stream<bool> stream;
  LicenseRepository() {
    stream = changeLicenseStatus.stream;
  }

  Future<bool> buyLicense() async {
    // TODO: buy license from server
    await Future.delayed(const Duration(seconds: 1));
    changeLicenseStatus.sink.add(true);
    return true;
  }
}
