// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

import 'package:polymer/polymer.dart';

main() => initPolymer();

@initMethod
void realMain() {
  Polymer.onReady.then((_) {
    // Elements have been upgraded.
  });
}
