import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...independentProviders,
  ..._dependentProviders,
];

List<SingleChildWidget> independentProviders = <SingleChildWidget>[];

List<SingleChildWidget> _dependentProviders = <SingleChildWidget>[
  // ProxyProvider<BannerApiService, BannerRepository>(
  //   update: (_, BannerApiService apiService, BannerRepository? repository) =>
  //       BannerRepository(
  //     apiService: apiService,
  //   ),
  // ),
];
