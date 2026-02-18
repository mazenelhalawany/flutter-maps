import 'package:flutter/material.dart';
import 'package:flutter_application_testmaps/core/features/auth/cubit/login_state.dart';
import '../../../constants/colors.dart';
import '../../auth/cubit/login_cubit.dart';
import '../../auth/view/login_view.dart';
import '../view/places.dart';
import '../../../utils/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/pictures.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  AuthCubit phoneAuthCubit = AuthCubit();

  Widget buildDrawerHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            AppImages.personal,
            fit: BoxFit.cover,
            height: 100,
          ),
        ),
        Text(
          'Mazen Ahmed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Text(
                state.number,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }

  Widget buildDrawerListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: color ?? AppColors.blue),
      title: Text(title),
      trailing: trailing ??= Icon(Icons.arrow_right, color: AppColors.blue),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(height: 0, thickness: 1, indent: 18, endIndent: 24);
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (!await canLaunchUrl(uri)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Cannot open link")));
        return;
      }

      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error opening link: $e")));
    }
  }

  Widget buildIcon(IconData icon, String url, BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(context, url),
      child: Icon(icon, color: AppColors.blue, size: 35),
    );
  }

  Widget buildSocialMediaIcons(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          buildIcon(
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/',
            context,
          ),
          const SizedBox(width: 15),
          buildIcon(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/',
            context,
          ),
          const SizedBox(width: 20),
          buildIcon(FontAwesomeIcons.telegram, 'https://t.me/OmarX14', context),
        ],
      ),
    );
  }

  Widget buildLogoutBlocProvider(BuildContext context) {
    return SizedBox(
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () async {
          await context.read<AuthCubit>().logout();
          AppNavigationType.navigate(
            context,
            page: LoginView(),
            type: AppNavigation.pushReplacement,
          );
        },
        color: Colors.red,
        trailing: SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {
              AppNavigationType.navigate(
                context,
                page: SavedPlacesView(),
                type: AppNavigation.push,
              );
            },
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
          const SizedBox(height: 180),
          ListTile(
            leading: Text(
              'Follow us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          buildSocialMediaIcons(context),
        ],
      ),
    );
  }
}
