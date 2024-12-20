import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendInfoScreen extends ConsumerStatefulWidget{
  static String get routeName =>"friendinfopage";
  const FriendInfoScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendInfoScreenState();
}

class _FriendInfoScreenState extends ConsumerState<FriendInfoScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}