import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
    this.enableFreeSwag = false,
  });

  final bool loggedIn;
  final void Function() signOut;
  final bool enableFreeSwag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: IconButton(
              onPressed: () {
                !loggedIn ? context.push('/sign-in') : signOut();
              },
              icon: !loggedIn ? const Text('sign-in') : const Text('Logout')),
        ),
        Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: IconButton(
                  onPressed: () {
                    context.push('/profile');
                  },
                  icon: const Text('Profile')),
            )),
        Visibility(
            visible: enableFreeSwag,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: IconButton(
                  onPressed: () {
                    throw Exception('free swag unimplemented');
                  },
                  icon: const Text('Free swag!')),
            )),
      ],
    );
  }
}
