import 'package:flutter/material.dart';

import '../abstract_factory/factories/cupertino_widgets_factory.dart';
import '../abstract_factory/factories/material_widgets_factory.dart';
import '../abstract_factory/iwidgets_factory.dart';
import '../abstract_factory/widgets/iactivity_indicator.dart';
import '../abstract_factory/widgets/islider.dart';
import '../abstract_factory/widgets/iswitch.dart';
import '../constants/layout_constants.dart';
import 'factory_selection.dart';

class AbstractFactoryExample extends StatefulWidget {
  const AbstractFactoryExample({super.key});

  @override
  _AbstractFactoryExampleState createState() => _AbstractFactoryExampleState();
}

// 인스턴스들을 목록을 IWidgetsFactory 담다.
class _AbstractFactoryExampleState extends State<AbstractFactoryExample> {
  final List<IWidgetsFactory> widgetsFactoryList = [
    MaterialWidgetsFactory(),
    CupertinoWidgetsFactory(),
  ];
// ctivityIndicator , slider ,_switch = 초기화
  int _selectedFactoryIndex = 0;
//추상클래스정의
  late IActivityIndicator _activityIndicator;

  late ISlider _slider;
  double _sliderValue = 50.0;
  String get _sliderValueString => _sliderValue.toStringAsFixed(0);

  late ISwitch _switch;
  bool _switchValue = false;
  String get _switchValueString => _switchValue ? 'ON' : 'OFF';

//createWidgets 호출하여 위젯객체를 초기화
  @override
  void initState() {
    super.initState();
    _createWidgets();
  }

  void _createWidgets() {
    _activityIndicator =
        widgetsFactoryList[_selectedFactoryIndex].createActivityIndicator();
    _slider = widgetsFactoryList[_selectedFactoryIndex].createSlider();
    _switch = widgetsFactoryList[_selectedFactoryIndex].createSwitch();
  }

//indicator값은 조절해야 하는 값이 없기 때문에 setState에 포함되지 않는다.
  void _setSelectedFactoryIndex(int? index) {
    setState(() {
      _selectedFactoryIndex = index!;
      _createWidgets();
    });
  }

  void _setSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _setSwitchValue(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingL,
          ),
          child: Column(
            children: <Widget>[
              FactorySelection(
                widgetsFactoryList: widgetsFactoryList,
                selectedIndex: _selectedFactoryIndex,
                onChanged: _setSelectedFactoryIndex,
              ),
              const SizedBox(height: LayoutConstants.spaceL),
              Text(
                'Widgets showcase',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: LayoutConstants.spaceXL),
              Text(
                'Process indicator',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: LayoutConstants.spaceL),
              _activityIndicator.render(),
              const SizedBox(height: LayoutConstants.spaceXL),
              Text(
                'Slider ($_sliderValueString%)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: LayoutConstants.spaceL),
              _slider.render(_sliderValue, _setSliderValue),
              const SizedBox(height: LayoutConstants.spaceXL),
              Text(
                'Switch ($_switchValueString)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: LayoutConstants.spaceL),
              _switch.render(
                value: _switchValue,
                onChanged: _setSwitchValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
