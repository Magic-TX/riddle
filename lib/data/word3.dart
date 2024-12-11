class WordDescription3 {
  final String word;
  final String description;
  final List<String> letters;

  WordDescription3({required this.word, required this.description})
      : letters = _generateLetters(word);

  static List<String> _generateLetters(String word) {
    List<String> letters = word.toUpperCase().split('');
    letters.addAll(['R', 'P']);
    letters.shuffle();
    return letters;
  }
}

List<WordDescription3> wordsList = [
  WordDescription3(
    word: "TAJ",
    description: "A symbol of love and an iconic mausoleum in India.",
  ),
  WordDescription3(
    word: "BENTO",
    description: "A Japanese lunch box with neatly arranged meals.",
  ),
  WordDescription3(
    word: "FALCON",
    description: "A bird of prey significant in Middle Eastern and Asian cultures.",
  ),
  WordDescription3(
    word: "JADE",
    description: "A precious stone symbolizing purity and virtue in Asia.",
  ),
  WordDescription3(
    word: "SAMOSA",
    description: "A triangular pastry filled with spiced vegetables or meat.",
  ),
  WordDescription3(
    word: "PANDA",
    description: "A beloved bear native to China.",
  ),
  WordDescription3(
    word: "KOTO",
    description: "A traditional Japanese stringed musical instrument.",
  ),
  WordDescription3(
    word: "MONSOON",
    description: "Seasonal rains crucial for agriculture in South Asia.",
  ),
  WordDescription3(
    word: "SILK",
    description: "A luxurious fabric historically traded on the Silk Road.",
  ),
  WordDescription3(
    word: "TEMPLE",
    description: "A sacred structure found across Asia, dedicated to worship.",
  ),
  WordDescription3(
    word: "CHAI",
    description: "A spiced tea popular in South Asia.",
  ),
  WordDescription3(
    word: "ORIGAMI",
    description: "The Japanese art of paper folding.",
  ),
  WordDescription3(
    word: "RICKSHAW",
    description: "A two-wheeled transport pulled by a person, common in Asia.",
  ),
  WordDescription3(
    word: "PEONY",
    description: "A flower often associated with honor and prosperity in Asia.",
  ),
  WordDescription3(
    word: "SHOGUN",
    description: "A military leader in feudal Japan.",
  ),
  WordDescription3(
    word: "MANDALA",
    description: "A geometric design symbolizing the universe in Buddhist culture.",
  ),
  WordDescription3(
    word: "IKIGAI",
    description: "A Japanese concept meaning 'reason for being.'",
  ),
  WordDescription3(
    word: "TEMPLE",
    description: "A place of worship for many Asian religions.",
  ),
  WordDescription3(
    word: "LANTERN",
    description: "A light source often used in Asian festivals.",
  ),
  WordDescription3(
    word: "TOFU",
    description: "A soybean product, widely used in Asian cuisines.",
  ),
];
