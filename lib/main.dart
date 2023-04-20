import 'package:advanced_widgets/providers/theme_provider.dart';
import 'package:advanced_widgets/widgets/inner_shadow_widget.dart';
import 'package:advanced_widgets/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: themeProvider.themeColor.name),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late bool _infoVisibility;
  late final AnimationController _zoomController;
  late double _weatherValue;
  late String _weatherText;

  @override
  void initState() {
    _infoVisibility = false;
    _weatherValue = 0;
    _weatherText = 'Ясно';
    super.initState();
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 1,
      upperBound: 3,
    );
  }

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  void zoomWeatherWidget() {
    if (_zoomController.value == 1) {
      _zoomController.forward();
      setState(() {
        _infoVisibility = true;
      });
    } else {
      _zoomController.reverse();
      setState(() {
        _infoVisibility = false;
      });
    }
  }

  void setWeather(value) {
    setState(() {
      _weatherValue = double.tryParse(value) ?? 0;
      if (_weatherValue == 0) {
        _weatherText = 'Ясно';
      } else if (_weatherValue < 0.5) {
        _weatherText = 'Облачно';
      } else {
        _weatherText = 'Дождь';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Theme(
      data: themeProvider.current,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: AnimatedBuilder(
                  animation: _zoomController,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: GestureDetector(
                          onTap: () => zoomWeatherWidget(),
                          child: CustomPaint(
                            painter: WeatherWidget(value: _weatherValue),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _infoVisibility,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InnerShadow(
                            blur: 5,
                            color: const Color(0xFF477C70),
                            offset: const Offset(5, 5),
                            child: Text(
                              _weatherText,
                              style:
                                  TextStyle(fontSize: 18 * _zoomController.value),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      transformHitTests: true,
                      alignment: Alignment.topRight,
                      scale: _zoomController.value,
                      child: child,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 300,
              ),
              Align(
                alignment: Alignment.center,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Weather',
                  ),
                  onSubmitted: (value) => setWeather(value),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              themeProvider.toggle(nextEnum(themeProvider.themeColor)),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
