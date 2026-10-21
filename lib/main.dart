import 'package:flutter/material.dart';

void main() {
  runApp(const MauDspApp());
}

class MauDspApp extends StatelessWidget {
  const MauDspApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAU DSP',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0F12),
        primaryColor: const Color(0xFF00E5FF),
      ),
      home: const MauDspHome(),
    );
  }
}

class MauDspHome extends StatefulWidget {
  const MauDspHome({Key? key}) : super(key: key);

  @override
  State<MauDspHome> createState() => _MauDspHomeState();
}

class _MauDspHomeState extends State<MauDspHome> {
  bool isPlaying = false;
  String activePreset = 'Off';
  double custom1Value = 5.0;
  double custom2Value = 7.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MAU DSP // AUDIO',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Color(0xFF00E5FF),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF080A0C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161A22),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00E5FF), width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'DSP STATUS',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        activePreset.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF00E5FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF080A0C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(16, (index) {
                        return Container(
                          width: 4,
                          height: isPlaying ? (15.0 + (index * 4) % 50) : 10.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5FF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00E5FF),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withOpacity(0.4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ACOUSTIC & CUSTOM PRESETS',
                style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.8,
              children: [
                _buildButton('Stadium'),
                _buildButton('Hall'),
                _buildButton('Large Room'),
                _buildButton('Off'),
                _buildButton('Custom 1'),
                _buildButton('Custom 2'),
              ],
            ),
            if (activePreset == 'Custom 1' || activePreset == 'Custom 2') ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF161A22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CONFIG: $activePreset',
                      style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: activePreset == 'Custom 1' ? custom1Value : custom2Value,
                      min: 0,
                      max: 10,
                      activeColor: const Color(0xFF00E5FF),
                      onChanged: (val) {
                        setState(() {
                          if (activePreset == 'Custom 1') {
                            custom1Value = val;
                          } else {
                            custom2Value = val;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String name) {
    bool isActive = activePreset == name;
    return InkWell(
      onPressed: () {
        setState(() {
          activePreset = name;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00E5FF) : const Color(0xFF161A22),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? Colors.white : const Color(0xFF2B313B)),
        ),
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
