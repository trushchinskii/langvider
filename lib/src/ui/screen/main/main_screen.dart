import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/main/main_wm.dart';

class MainScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _MainState();
}

class _MainState extends BaseWidgetState<MainScreen, MainScreenWm> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: _buildDrawer(),
      body: Center(
        child: StreamBuilder(
          stream: wm.openNewWordScreenSC.stream,
          builder: (context, AsyncSnapshot<void> snapshot) {
            // TODO
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => wm.openNewWordScreen.add(null),
      );

  Widget _buildDrawer() {
    // TODO implement Drawer
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
    );
  }
}
