import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/Config/config_page.dart';
import 'package:manipedi_studio/app/modules/client/client_module.dart';
import 'package:manipedi_studio/app/modules/result/result_page.dart';
import 'package:manipedi_studio/app/modules/schedule/schedule_page.dart';
import 'package:manipedi_studio/app/modules/service/service_page.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageViewController,
        children: [
          SchedulePage(),
          RouterOutlet(module: CustomerModule()),
          ServicePage(),
          ResultPage(),
          ConfigPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget BottomNavigator() {
    return AnimatedBuilder(
        animation: controller.pageViewController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: controller.pageViewController?.page?.round() ?? 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.pink[800],
            selectedFontSize: 22,
            onTap: (index) {
              controller.pageViewController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Agenda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Clientes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_business_rounded),
                label: 'Seviços',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Results',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.miscellaneous_services),
                label: 'Configs',
              ),
            ],
          );
        });
  }
}
