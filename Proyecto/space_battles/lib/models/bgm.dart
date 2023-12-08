class BGM {
  int bgmID;
  String name;

  BGM({
    required this.bgmID,
    required this.name,
  });

  static final bgms = <BGM>[
    BGM(bgmID: 0, name: 'No BGM'),
    BGM(bgmID: 1, name: '1. Neon Road Trip.wav'),
    BGM(bgmID: 2, name: '2. Spaceman.wav'),
    BGM(bgmID: 3, name: '3. Psychedelia Flashback.wav'),
    BGM(bgmID: 4, name: '4. No Pressure Trance.wav'),
    BGM(bgmID: 5, name: '5. Romance on Neon.wav'),
    BGM(bgmID: 6, name: '6. 80s, Disco, Life.wav'),
    BGM(bgmID: 7, name: '7. The SynthRave.wav'),
    BGM(bgmID: 8, name: '8. ZoomBeats.wav'),
    BGM(bgmID: 9, name: '9. Space Invaders.wav'),
    BGM(bgmID: 10, name: '10. Laser Party.wav'),
    BGM(bgmID: 11, name: '11. Flanger Party.wav'),
    BGM(bgmID: 12, name: '12. SynthBomb.wav'),
    BGM(bgmID: 13, name: '13. Night Life.wav'),
    BGM(bgmID: 14, name: '14. Retro Noir.wav'),
    BGM(bgmID: 15, name: '15. Trickle Bass.wav'),
  ];

  BGM.fromMap(Map<String, dynamic> map)
      : bgmID = map['bgmID'],
        name = map['name'];

  static Map<String, dynamic> defaultData = {
    'bgmID': 1,
    'name': '1. Neon Road Trip.wav',
  };

  static List<String> getNames(List<BGM> bgms) {
    List<String> names = [];
    for (int i = 1; i < bgms.length; i++) {
      names.add(bgms[i].name);
    }
    return names;
  }
}
