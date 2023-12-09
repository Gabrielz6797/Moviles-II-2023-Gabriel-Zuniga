/// [BGM] Class that contains info about the BGMs
class BGM {
  int bgmID;
  String name;

  BGM({
    required this.bgmID,
    required this.name,
  });

  static final bgms = <BGM>[
    BGM(bgmID: 0, name: 'No BGM'),
    BGM(bgmID: 1, name: '1. Neon Road Trip.ogg'),
    BGM(bgmID: 2, name: '2. Spaceman.ogg'),
    BGM(bgmID: 3, name: '3. Psychedelia Flashback.ogg'),
    BGM(bgmID: 4, name: '4. No Pressure Trance.ogg'),
    BGM(bgmID: 5, name: '5. Romance on Neon.ogg'),
    BGM(bgmID: 6, name: '6. 80s, Disco, Life.ogg'),
    BGM(bgmID: 7, name: '7. The SynthRave.ogg'),
    BGM(bgmID: 8, name: '8. ZoomBeats.ogg'),
    BGM(bgmID: 9, name: '9. Space Invaders.ogg'),
    BGM(bgmID: 10, name: '10. Laser Party.ogg'),
    BGM(bgmID: 11, name: '11. Flanger Party.ogg'),
    BGM(bgmID: 12, name: '12. SynthBomb.ogg'),
    BGM(bgmID: 13, name: '13. Night Life.ogg'),
    BGM(bgmID: 14, name: '14. Retro Noir.ogg'),
    BGM(bgmID: 15, name: '15. Trickle Bass.ogg'),
  ];

  BGM.fromMap(Map<String, dynamic> map)
      : bgmID = map['bgmID'],
        name = map['name'];

  static Map<String, dynamic> defaultData = {
    'bgmID': 1,
    'name': '1. Neon Road Trip.ogg',
  };

  static List<String> getNames(List<BGM> bgms) {
    List<String> names = [];
    for (int i = 1; i < bgms.length; i++) {
      names.add(bgms[i].name);
    }
    return names;
  }
}
