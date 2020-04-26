import 'package:flutter/material.dart';
import 'package:langvider/src/ui/base/screen/base_widget.dart';
import 'package:langvider/src/ui/screen/main/main_wm.dart';
import 'package:langvider/src/ui/utils/colors.dart';
import 'package:langvider/src/ui/utils/text_styles.dart';

class MainScreen extends BaseWidget {
  @override
  BaseWidgetState buildState() => _MainState();
}

class _MainState extends BaseWidgetState<MainScreen, MainScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildFloatingActionButton() => FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: wm.openNewWordScreenAction,
      );

  Widget _buildDrawer() {
    // TODO implement Drawer
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
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
          const ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: const Text('Debug screen'),
            onTap: wm.openDebugScreenAction,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() => SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            _buildDictionary(),
            const SizedBox(height: 16),
            _buildTrainings(),
          ],
        ),
      );

  Widget _buildDictionary() => _MainListTile(
        title: str.mainScreenDictionaryTitle,
        onPressed: wm.openDictionaryScreenAction,
      );
  Widget _buildTrainings() => _MainListTile(
        title: str.mainScreenTrainingsTitle,
        onPressed: wm.openTrainingsScreenAction,
      );
}

class _MainListTile extends StatelessWidget {
  const _MainListTile({
    @required this.title,
    @required this.onPressed,
    Key key,
  })  : assert(title != null && onPressed != null),
        super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RaisedButton(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: h5,
          ),
        ),
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        color: reefColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      shape: const CircularNotchedRectangle(),
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
