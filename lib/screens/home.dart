import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../common/static.dart';
import '../common/widgets/audio_call.dart';
import '../common/widgets/call_invitation.dart';
import '../common/widgets/top_bar.dart';
import '../common/widgets/user_card.dart';
import '../models/user.dart';
import '../services/firebase_service.dart';
// import 'package:zego_cloud/common/widgets/call_invitation.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Statics.appID,
      appSign: Statics.appSign,
      userID: FirebaseService.currentUser.name,
      userName: FirebaseService.currentUser.name,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    onUserLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(
              upperTitle: 'Welcome back,',
              title: FirebaseService.currentUser.name,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseService.buildViews,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
                  if (docs == null || docs.isEmpty) {
                    return const Text('No data');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final model = UserModel.fromJson(
                        docs[index].data() as Map<String, dynamic>,
                      );
                      if (model.username !=
                          FirebaseService.currentUser.username) {
                        return UserCard(userModel: model);
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
