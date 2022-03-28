/// Pulled from [https://stackoverflow.com/a/67686297/13365850],
/// posted by Pierre [https://stackoverflow.com/users/1876355/pierre]
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ly_project/utils/colors.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final CachedNetworkImage child;
  final bool dark;

  ImageFullScreenWrapperWidget({
    @required this.child,
    this.dark = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenPage(child: child, dark: dark),
        ),
      ),
      child: child,
    );
  }
}

class FullScreenPage extends StatefulWidget {
  FullScreenPage({
    @required this.child,
    @required this.dark,
  });

  final CachedNetworkImage child;
  final bool dark;

  @override
  _FullScreenPageState createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
  @override
  void initState() {
    var brightness = widget.dark ? Brightness.light : Brightness.dark;
    var color = widget.dark ? Colors.black12 : Colors.white70;

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      statusBarColor: color,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
      systemNavigationBarDividerColor: color,
      systemNavigationBarIconBrightness: brightness,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // Restore your settings here...
        ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: widget.dark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: DARK_BLUE,
          title: Text("Image"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.1,
              maxScale: 5,
              child: widget.child,
            ),
          ],
        ),
      );
}