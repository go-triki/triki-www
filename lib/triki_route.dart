// Copyright (c) 2015, Kornel Maczyński. All rights reserved. Use of this source
// code is governed by AGPLv3 license that can be found in the license file.
// If you want to contribute read the rules in the contributing file.

import 'dart:html';
import 'package:route_hierarchical/client.dart';

import 'package:polymer/polymer.dart';

/// Element representing a route. To be used as a direct child of triki-router.
@CustomTag('triki-route')
class TrikiRoute extends PolymerElement {
	/// Route path represented by this element.
	@published String path;
	/// Route name
	@published String name;
	/// Is it a default route?
	@published bool defaultRoute = false;
	
	TrikiRoute.created() : super.created();
	
	/// mount recursively adds all routes described by this triki-route element to r.
	void mount(Route r) {
		ElementList<TrikiRoute> list = this.querySelectorAll('#me > triki-route');
		var mount = null;
		if (list != null && !list.isEmpty) {
			mount = (Route r) {
				for (TrikiRoute tr in list) {
					tr.mount(r);
				}
			};
		}
		r.addRoute(
				name: name,
				path: path,
				defaultRoute: defaultRoute,
				mount: mount,
				enter: (RouteEnterEvent e) {
					print("triki-router route: ${e.path}");
			});
	}
}
