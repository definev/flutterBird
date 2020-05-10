class AssetName {
  static Audio audio = Audio();
  static Sprites sprites = Sprites();
}

class Audio {
  String dieOGG = 'assets/audio/die.ogg';
  String hitOGG = 'assets/audio/hit.ogg';
  String pointOGG = 'assets/audio/point.ogg';
  String swooshOGG = 'assets/audio/swoosh.ogg';
  String wingOGG = 'assets/audio/wing.ogg';
  String dieWAV = 'assets/audio/die.wav';
  String hitWAV = 'assets/audio/hit.wav';
  String pointWAV = 'assets/audio/point.wav';
  String swooshWAV = 'assets/audio/swoosh.wav';
  String wingWAV = 'assets/audio/wing.wav';
}

class Sprites {
  String num0 = 'assets/sprites/0.png';
  String num1 = 'assets/sprites/1.png';
  String num2 = 'assets/sprites/2.png';
  String num3 = 'assets/sprites/3.png';
  String num4 = 'assets/sprites/4.png';
  String num5 = 'assets/sprites/5.png';
  String num6 = 'assets/sprites/6.png';
  String num7 = 'assets/sprites/7.png';
  String num8 = 'assets/sprites/8.png';
  String num9 = 'assets/sprites/9.png';
  String backgroundDay = 'assets/sprites/background-day.png';
  String backgroundNight = 'assets/sprites/background-night.png';
  String base = 'assets/sprites/base.png';
  String gameOver = 'assets/sprites/gameover.png';
  String message = 'assets/sprites/message.png';
  String redPipe = Pipe.getPipeByColor('red');
  String greenPipe = Pipe.getPipeByColor('green');
  Bird redBird = Bird('red');
  Bird blueBird = Bird('blue');
  Bird yellowBird = Bird('yellow');
}

class Pipe {
  static String getPipeByColor(String color) =>
      'assets/sprites/pipe-$color.png';
}

class Bird {
  final String color;

  Bird(this.color);

  String getDownFlap() => 'assets/sprites/${color}bird-downflap.png';
  String getMidFlap() => 'assets/sprites/${color}bird-midflap.png';
  String getUpFlap() => 'assets/sprites/${color}bird-upflap.png';
}
