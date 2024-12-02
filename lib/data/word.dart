class WordDescription {
  final String word;
  final String description;
  final List<String> letters;

  WordDescription({required this.word, required this.description})
      : letters = _generateLetters(word);

  static List<String> _generateLetters(String word) {
    List<String> letters = word.toUpperCase().split('');
    letters.addAll(['L', 'Y']);
    letters.shuffle();
    return letters;
  }
}

List<WordDescription> wordsList = [
  WordDescription(
    word: "SAKURA",
    description: "A symbol of Japan, a blooming cherry tree.",
  ),
  WordDescription(
    word: "SUSHI",
    description: "A dish of rice and seafood, famous worldwide.",
  ),
  WordDescription(
    word: "KIMONO",
    description: "Traditional Japanese clothing.",
  ),
  WordDescription(
    word: "GEISHA",
    description: "A woman artist with many talents.",
  ),
  WordDescription(
    word: "TEA",
    description: "A popular drink, especially valued in China and Japan.",
  ),
  WordDescription(
    word: "FUJI",
    description: "The tallest mountain in Japan.",
  ),
  WordDescription(
    word: "TATAMI",
    description: "A mat used to cover floors in Japanese homes.",
  ),
  WordDescription(
    word: "HANAMI",
    description: "The tradition of enjoying cherry blossom viewing.",
  ),
  WordDescription(
    word: "NINJA",
    description: "A spy and warrior from ancient Japan.",
  ),
  WordDescription(
    word: "SAMURAI",
    description: "A warrior following the bushido code of honor.",
  ),
  WordDescription(
    word: "MANGA",
    description: "Japanese comics popular worldwide.",
  ),
  WordDescription(
    word: "ANIME",
    description: "Japanese animation with diverse genres.",
  ),
  WordDescription(
    word: "TEMPURA",
    description: "A dish of seafood or vegetables in batter.",
  ),
  WordDescription(
    word: "KATANA",
    description: "A traditional Japanese sword.",
  ),
  WordDescription(
    word: "BONSAI",
    description: "The art of miniature tree cultivation.",
  ),
  WordDescription(
    word: "RICKSHAW",
    description: "A traditional mode of transportation in Asia.",
  ),
  WordDescription(
    word: "IZUMO",
    description: "An ancient shrine in Japan.",
  ),
  WordDescription(
    word: "TSUNAMI",
    description: "A large wave caused by an earthquake.",
  ),
  WordDescription(
    word: "ONIGIRI",
    description: "Rice balls with filling, popular in Japan.",
  ),
  WordDescription(
    word: "MISO",
    description: "A traditional Japanese soup made from soybean paste.",
  ),
];
