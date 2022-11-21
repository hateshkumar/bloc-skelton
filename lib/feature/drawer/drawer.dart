import 'package:reliable_hands/config/export.dart';
import 'package:reliable_hands/core/blocs/cubit_provider.dart';
import 'package:reliable_hands/core/util/reliable_storage.dart';
import 'package:reliable_hands/core/widgets/image_loader.dart';
import 'package:reliable_hands/domain/entites/auth_member.dart';
import 'package:reliable_hands/feature/drawer/drawer_cubit.dart';

import '../../core/widgets/loaders/reliable_loader.dart';

class ReliableDrawer extends StatefulWidget {
  const ReliableDrawer({Key? key}) : super(key: key);

  @override
  State<ReliableDrawer> createState() => _ReliableDrawerState();
}

class _ReliableDrawerState extends State<ReliableDrawer> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<ReliableBaseState, DrawerCubit>(
        create: (context) => DrawerCubit(),
        builder: (context, state, bloc) {
          return StreamBuilder<AuthMember>(
              stream: bloc.memberSubject$,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return Drawer(
                  child: ReliableFullScreenProgressIndicator(
                    enabled: state.secondaryBusy,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              UserAccountsDrawerHeader(
                                accountName: drawerTitle(snapshot.data!.name!),
                                accountEmail:
                                    drawerTitle(snapshot.data!.phone!),
                                currentAccountPicture: ReliableImageLoader(
                                    imageUrl: snapshot.data!.photo ?? ""),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF009444),
                                ),
                              ),
                              drawerContent(Icons.person, "My Profile",
                                  onTap: () {
                                NavigatorHelper().navigateTo('/user_data/0');
                              }),
                              drawerContent(Icons.add_chart, "Add Crop",onTap: (){
                                NavigatorHelper().navigateTo('/crops');

                              }),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 4.h),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 6.h,
                                color: const Color(0xFF009444),
                                child: ReliableText.subHeaderText(
                                  text: "Logout",
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            onTap: () => ReliableStorage.logout(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget drawerTitle(String text) {
    return ReliableText.subHeaderText(
      text: text,
      fontSize: 12.sp,
      color: APPColors.appWhite,
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }

  Widget drawerContent(IconData icon, String text, {VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.5.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: APPColors.appBlack,
            ),
            SizedBox(
              width: 3.w,
            ),
            ReliableText.subHeaderText(
              text: text,
              fontSize: 14.sp,
              color: APPColors.appBlack,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: APPColors.appBlack,
              size: 4.w,
            )
          ],
        ),
      ),
    );
  }
}
