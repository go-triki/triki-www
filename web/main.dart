// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the license file.
// If you want to contribute read the rules in the contributing file.

import 'package:polymer/polymer.dart';

void main() {
	initPolymer().run(() {
		// Code here is in the polymer Zone, which ensures that
		// @observable properties work correctly.
		Polymer.onReady.then((_) {
			// Elements have been upgraded.
		});
	});
}
