import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugoi/api/api.dart';
import 'package:sugoi/cubit/custome_cubit.dart';
import 'package:sugoi/models/customer.dart';
import 'package:sugoi/screens/sign_in_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _api = Api();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, Customer?>(
      buildWhen: (previous, current) => previous != current && current != null,
      builder: _buildCubit,
    );
  }

  Widget _buildCubit(BuildContext context, Customer? customer) {
    final screenWidth = MediaQuery.of(context).size.width;
    final profileWidget = ListTile(
      leading: Icon(Icons.account_circle_outlined, size: screenWidth * 0.25),
      title: Transform.translate(
        offset: Offset(screenWidth * 0.02, screenWidth * 0.04),
        child: Text(customer?.name ?? "---",
          style: TextStyle(fontSize: screenWidth * 0.05,)
        ),
      ),
      subtitle: Transform.translate(
        offset: Offset(screenWidth * 0.02, screenWidth * 0.04),
        child: Text(customer?.phoneNumber ?? "---"),
      ),
    );

    final profileOptions = ListTile.divideTiles(
      context: context,
      tiles: <Widget>[
        ListTile(
          title: const Text("Ubah Profil"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Keluar"),
          onTap: () async {
            await _api.signOut();
            if (!mounted) {
              return;
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const SignInScreen()),
                  (route) => false,
            );
          },
        ),
      ],
    ).toList();

    List<Widget> scrollableWidgets = [
      profileWidget,
      SizedBox(height: screenWidth * 0.1),
    ];
    scrollableWidgets.addAll(profileOptions);

    return ListView(
      children: scrollableWidgets,
    );
  }
}
