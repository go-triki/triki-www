// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

import 'dart:html';
import 'package:polymer/polymer.dart';

bool _verifyUrl(String url) {
  try {
    Uri.parse(url);
  } catch (_) {
    return false;
  }
  return true;
}

main() {
  // try to guard against malformed urls
  String url = window.location.href;
  if (!_verifyUrl(url)) {
    int i = url.indexOf('#');
    if (i > 0) {
      url = url.substring(0, i);
      window.location.href = url;
      if (!_verifyUrl(url)) {
        document.title = 'Trikipedia: malformed address.';
        return;
      }
    } else {
      document.title = 'Trikipedia: malformed address.';
      return;
    }
  }
  // start polymer
  initPolymer();
}

@initMethod
void realMain() {
  Polymer.onReady.then((_) {
    // Elements have been upgraded.
  });
}
