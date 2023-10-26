import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_bloc.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_event.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_state.dart';
import 'package:second_hand_mobils/screens/home_screen.dart';
import 'package:second_hand_mobils/screens/user_screen.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const UserLogOutScreen(),
    ];
    context.read<AppBloc>().add(TabChangedEvent(tabIndex: 0));
    return BlocSelector<AppBloc, AppState, TabChangedState>(
      selector: (state) {
        return state as TabChangedState;
      },
      builder: (context, state) {
        return Scaffold(
          body: widgetOptions[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<AppBloc>().add(TabChangedEvent(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
