import 'dart:async';
import 'package:backend/backend.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {
  final handler = await startShelfModular();
  final server = await io.serve(handler, '0.0.0.0', 4466);
  print('Online - ${server.address.address}: ${server.port}');
}



//----------------------------- UTILIZADO APENAS PARA ESTUDO -------------------------------
// Middleware log() {
//   return (handler) {
//     return (request) async {
//       // antes de executar
//       print('solicitado: ${request.url}');
//       var response = await handler(request);

//       //depois de executar
//       print('[${response.statusCode}] - Response');
//       return response;
//     };
//   };
// }

// FutureOr<Response> _handler(Request request) {
//   print(request);
//   return Response(200, body: "Corpo");
// }
//------------------------------------------------------------------------------------------