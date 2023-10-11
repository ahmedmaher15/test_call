import 'package:flutter/cupertino.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../static.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.userName}) : super(key: key);
  final String callID;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Statics.appID,
      appSign: Statics.appSign,
      userID: userName,
      userName: userName,
      callID: callID,

      // Modify your custom configurations here.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..turnOnCameraWhenJoining = false
        ..turnOnMicrophoneWhenJoining = false
        ..useSpeakerWhenJoining = true,
    );
  }
}