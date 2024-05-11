import 'package:backend/src/features/user/user_resource.dart';
import 'package:modular_interfaces/src/route/modular_key.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('Inicial')),
        Route.resource(UserResource())
      ];
}
