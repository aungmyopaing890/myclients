import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/client/core/service/client_db_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...independentProviders,
  ..._dependentProviders,
];

List<SingleChildWidget> independentProviders = <SingleChildWidget>[
  Provider<ClientDbService>.value(value: ClientDbService.instance),
];

List<SingleChildWidget> _dependentProviders = <SingleChildWidget>[
  ProxyProvider<ClientDbService, ClientRepository>(
    update: (_, ClientDbService dbService, ClientRepository? repository) =>
        ClientRepository(
      dbService: dbService,
    ),
  ),
];
