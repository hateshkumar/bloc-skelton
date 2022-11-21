import 'package:reliable_hands/config/export.dart';
import 'package:reliable_hands/core/blocs/cubit_provider.dart';
import 'package:reliable_hands/feature/splash/auth_cubit.dart';

import '../../core/widgets/loaders/reliable_secondary_loader.dart';

class SplashView extends StatefulWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<ReliableBaseState, AuthCubit>(
        create: (context) => AuthCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
              body: SafeArea(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Assets.images.logo.image(width: 250, height: 250),
                SizedBox(
                  height: 5.h,
                ),
                ReliableSecondaryScreenProgressIndicator(
                  enabled: state.secondaryBusy,
                ),
                const Spacer(),
                Container(
                  margin: PagePadding.horizontalSymmetric(10.w),
                  child: ReliableButton.primaryFilled(
                    label: 'Get Started',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            )),
          ));
        });
  }
}
