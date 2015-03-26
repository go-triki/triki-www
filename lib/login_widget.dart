// Copyright (c) 2014, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the LICENSE file.
// If you want to contribute read the rules in the CONTRIBUTING file.

library login_widget;

import 'package:polymer/polymer.dart';

@CustomTag('login-widget')
class LoginWidget extends PolymerElement {
	@observable bool loggedIn;

  LoginWidget.created() : super.created();
}
