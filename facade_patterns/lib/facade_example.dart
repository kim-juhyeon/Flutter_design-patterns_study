import 'package:flutter/material.dart';
import 'package:facade_patterns/smart_home_facade.dart';
import 'package:facade_patterns/smart_home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SmartHomeState _smartHomeState = SmartHomeState();
  final SmartHomeFacade _smartHomeFacade = SmartHomeFacade();

//초기값으로 아무것도 선택 되지 않게 설정해줍니다.
  bool _homeCinemaModeOn = false;
  bool _gamingModeOn = false;
  bool _streamingModeOn = false;

//_isAnyModeOn 부울값들(시네마,게이밍,스트림모드)을 결합하여 켜져 있는지 여부결정
// switcher가
  bool get _isAnyModeOn =>
      _homeCinemaModeOn || _gamingModeOn || _streamingModeOn;
/*"비활성"에서 "활성" 수명 주기 상태로 전환합니다.

프레임워크는 이전에 비활성화된 요소가 트리에 다시 통합되었을 때 이 메서드를 호출합니다. 
프레임워크는 요소가 처음 활성화될 때(즉, "초기" 수명 주기 상태에서) 이 메서드를 호출하지 않습니다. 
대신 프레임워크는 해당 상황에서 마운트를 호출합니다 . */
  void _changeHomeCinemaMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startMovie(_smartHomeState, movieTitle: 'mo');
    } else {
      _smartHomeFacade.stopMovie(_smartHomeState);
    }

    setState(() {
      _homeCinemaModeOn = activated;
    });
  }

  void _changeGamingMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startGaming(_smartHomeState);
    } else {
      _smartHomeFacade.stopGaming(_smartHomeState);
    }

    setState(() {
      _gamingModeOn = activated;
    });
  }

  void _changeStreamingMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startStreaming(_smartHomeState);
    } else {
      _smartHomeFacade.stopStreaming(_smartHomeState);
    }

    setState(() {
      _streamingModeOn = activated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: const Text('Home cinema mode'),
              value: _homeCinemaModeOn,
              onChanged: !_isAnyModeOn || _homeCinemaModeOn
                  ? _changeHomeCinemaMode
                  : null,
            ),
            SwitchListTile(
              title: const Text('Gaming mode'),
              value: _gamingModeOn,
              onChanged:
                  !_isAnyModeOn || _gamingModeOn ? _changeGamingMode : null,
            ),
            SwitchListTile(
              title: const Text('Streaming mode'),
              value: _streamingModeOn,
              onChanged: !_isAnyModeOn || _streamingModeOn
                  ? _changeStreamingMode
                  : null,
            ),
            ListTile(
              leading: Icon(_smartHomeState.tvOn ? Icons.tv : Icons.tv_off),
              title: const Text('TV'),
            ),
            ListTile(
              leading: Icon(_smartHomeState.audioSystemOn
                  ? Icons.speaker
                  : Icons.speaker_notes_off),
              title: const Text('Audio System'),
            ),
            ListTile(
              leading: Icon(_smartHomeState.lightsOn
                  ? Icons.tips_and_updates
                  : Icons.lightbulb),
              title: const Text('Lights'),
            ),
          ],
        ),
      ),
    );
  }
}
