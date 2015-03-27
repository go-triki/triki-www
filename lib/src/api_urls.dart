library api_urls;

class ApiUrl {
	static final String _server = "";
	static final String _api = "/api";
	static final String login = url('auth/login');
	//static final String jsonType = 'application/json';

	static String url(String u) {
		return _server + _api + "/" + u;
	}
}
