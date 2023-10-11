import 'package:flutter/cupertino.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../static.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.username}) : super(key: key);

  final String callID;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall (
      appID: Statics.appID,
      appSign: Statics.appSign,
      userID: username,
      userName: username,
      callID: callID,

      // Modify your custom configurations here.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..avatarBuilder = (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
          return user != null
              ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://your_server/app/avatar/${user.id}.png',
                ),
              ),
            ),
          )
              : const SizedBox();
        },
    );
  }
}