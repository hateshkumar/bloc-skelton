
import 'package:reliable_hands/config/export.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Routes.configureRoutes(NavigatorHelper.router);
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, orientation, device) {
      return ReliableTheme(
          data: ReliableTheme.themeData,
          child: MaterialApp(
            scaffoldMessengerKey: globalBloc.rootScaffoldMessengerKey,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            title: 'Reliable',
            builder: (context, child) => DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText1!,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,                            
                  key: globalBloc.scaffoldKey,
                  body: child),
            ),
            navigatorKey: NavigatorHelper.navigatorKey,
            navigatorObservers: <NavigatorObserver>[
              // routeObserver,
              ReliableNavigatorObserver(),
            ],
            initialRoute: '/splash',
            onGenerateRoute: NavigatorHelper.router.generator,
            theme: ReliableTheme.generateThemeDataFromreliableHandsThemeData(
                ReliableTheme.themeData),
          )

      );
    });
  }

  Future<void> init() async {
    await RepositoryBarrel().initializeAll();
  }
}
