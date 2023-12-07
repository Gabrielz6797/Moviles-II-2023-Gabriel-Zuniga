class Spaceship {
  int spriteID;
  String assetPath;

  Spaceship({
    required this.spriteID,
    required this.assetPath,
  });

  static final spaceships = <Spaceship>[
    Spaceship(spriteID: 0, assetPath: 'assets/images/ship_A.png'),
    Spaceship(spriteID: 1, assetPath: 'assets/images/ship_B.png'),
    Spaceship(spriteID: 2, assetPath: 'assets/images/ship_C.png'),
    Spaceship(spriteID: 3, assetPath: 'assets/images/ship_D.png'),
    Spaceship(spriteID: 4, assetPath: 'assets/images/ship_E.png'),
    Spaceship(spriteID: 5, assetPath: 'assets/images/ship_F.png'),
    Spaceship(spriteID: 6, assetPath: 'assets/images/ship_G.png'),
    Spaceship(spriteID: 7, assetPath: 'assets/images/ship_H.png'),
    Spaceship(spriteID: 8, assetPath: 'assets/images/ship_I.png'),
    Spaceship(spriteID: 9, assetPath: 'assets/images/ship_J.png'),
    Spaceship(spriteID: 10, assetPath: 'assets/images/ship_K.png'),
    Spaceship(spriteID: 11, assetPath: 'assets/images/enemy_A.png'),
    Spaceship(spriteID: 12, assetPath: 'assets/images/enemy_B.png'),
    Spaceship(spriteID: 13, assetPath: 'assets/images/enemy_C.png'),
    Spaceship(spriteID: 14, assetPath: 'assets/images/enemy_D.png'),
    Spaceship(spriteID: 15, assetPath: 'assets/images/enemy_E.png'),
    Spaceship(spriteID: 16, assetPath: 'assets/images/ship_L.png'),
    Spaceship(spriteID: 17, assetPath: 'assets/images/ship_sidesA.png'),
    Spaceship(spriteID: 18, assetPath: 'assets/images/ship_sidesB.png'),
    Spaceship(spriteID: 19, assetPath: 'assets/images/ship_sidesC.png'),
    Spaceship(spriteID: 20, assetPath: 'assets/images/ship_sidesD.png'),
    Spaceship(spriteID: 21, assetPath: 'assets/images/station_A.png'),
    Spaceship(spriteID: 22, assetPath: 'assets/images/station_B.png'),
    Spaceship(spriteID: 23, assetPath: 'assets/images/station_C.png'),
  ];

  Spaceship.fromMap(Map<String, dynamic> map)
      : spriteID = map['spriteID'],
        assetPath = map['assetPath'];

  static Map<String, dynamic> defaultData = {
    'spriteID': 0,
    'assetPath': 'assets/images/ship_A.png',
  };
}
