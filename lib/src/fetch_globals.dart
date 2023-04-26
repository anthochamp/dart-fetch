import 'package:httpx_client/httpx_client.dart';

class FetchGlobals {
  static final _instance = FetchGlobals._();
  factory FetchGlobals() => _instance;

  FetchGlobals._();

  HttpxClient httpxClient = HttpxClient();
}
