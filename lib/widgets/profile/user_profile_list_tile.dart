import 'package:flutter/material.dart';

class UserProfileListTile extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData icon;

  const UserProfileListTile({
    Key? key,
    required this.onPress,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPress,
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
      ],
    );
  }
}