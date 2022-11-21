import 'package:dio/dio.dart';
import 'package:reliable_hands/config/export.dart';

import '../../service/error_service.dart';

class ReliableError extends StatelessWidget {
  final Widget child;

  const ReliableError({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    {
      return BehaviorSubjectBuilder<Response<dynamic>>(
          subject: ErrorService().error,
          builder: (context, snapshot) {
            print('here2 ${snapshot.data.toString()}');
            if (!snapshot.hasData) {
              return child;
            }
            if (snapshot.data!.statusCode == 200) {
              return child;
            }
            return Center(
              child: ReliableText.headerText(
                text: snapshot.data!.statusMessage,
                fontSize: 10.w,
                color: APPColors.appPrimaryColor,
              ),
            );
          });
    }
  }
}
