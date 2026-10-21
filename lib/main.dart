import 'package:flutter/material.dart';

void main() => runApp(const MauDspApp());

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
      home: const MauDspScreen(),
    );
  }
}

class MauDspScreen extends StatefulWidget {
  const MauDspScreen({Key? key}) : super(key: key);

  @override
  _MauDspScreenState createState() => _MauDspScreenState();
}

class _MauDspScreenState extends State<MauDspScreen> {
  bool isPlaying = false;
  String activePreset = 'Off';
  double trackProgress = 0.42;

  double custom1Value = 5.0;
  double custom2Value = 7.5;

  void applyPreset(String presetName) {
    setState(() {
      activePreset = presetName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MAU DSP // REFERENCE AUDIO',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
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
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF12161F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4), width: 1.5),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'DSP PROCESSOR',
                        style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.5),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.2),
                          border: Border.all(color: const Color(0xFF00E5FF)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          activePreset.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF00E5FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF080A0C),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF1F2937)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(24, (index) {
                        double heightFactor = (index % 5 == 0) ? 0.7 : ((index * 3) % 8 / 10);
                        if (!isPlaying) heightFactor = 0.15;
                        return Container(
                          width: 6,
                          height: 60 * heightFactor,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5FF),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF12161F),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF1F2937)),
              ),
              child: Column(
                children: [
                  const Text(
                    'MAU STUDIO MASTER - TRACK 01',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 10),
                  Slider(
                    value: trackProgress,
                    activeColor: const Color(0xFF00E5FF),
                    inactiveColor: const Color(0xFF21262D),
                    onChanged: (val) {
                      setState(() {
                        trackProgress = val;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1:35', style: TextStyle(color: Colors.grey, fontSize: 10)),
                        Text('3:50', style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 30, color: Colors.white70),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00E5FF),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 30, color: Colors.white70),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ACOUSTIC PROFILES & MANUAL PRESETS',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.8,
              children: [
                _buildPresetTile('Stadium', Icons.stadium),
                _buildPresetTile('Hall', Icons.theater_comedy),
                _buildPresetTile('Large Room', Icons.room),
                _buildPresetTile('Off', Icons.power_settings_new),
                _buildPresetTile('Custom 1', Icons.tune),
                _buildPresetTile('Custom 2', Icons.tune),
              ],
            ),
            if (activePreset == 'Custom 1' || activePreset == 'Custom 2') ...[
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF12161F),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MANUAL TUNE: ${activePreset.toUpperCase()}',
                      style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Level:', style: TextStyle(color: Colors.grey, fontSize: 11)),
                        Expanded(
                          child: Slider(
                            value: activePreset == 'Custom 1' ? custom1Value : custom2Value,
                            min: 0.0,
                            max: 10.0,
                            activeColor: const Color(0xFF00E5FF),
                            inactiveColor: const Color(0xFF21262D),
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
                        ),
                        Text(
                          (activePreset == 'Custom 1' ? custom1Value : custom2Value).toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
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

  Widget _buildPresetTile(String name, IconData icon) {
    final bool isActive = activePreset == name;
    return InkWell(
      onPressed: () => applyPreset(name),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00E5FF) : const Color(0xFF161A22),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? Colors.white : const Color(0xFF21262D),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.black : const Color(0xFF00E5FF),
            ),
            const SizedBox(width: 6),
            Text(
              name.toUpperCase(),
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
