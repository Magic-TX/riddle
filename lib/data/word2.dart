class WordDescription2 {
  final String word;
  final String description;
  final List<String> letters;

  WordDescription2({required this.word, required this.description})
      : letters = _generateLetters(word);

  static List<String> _generateLetters(String word) {
    List<String> letters = word.toUpperCase().split('');
    letters.addAll(['X', 'W']);
    letters.shuffle();
    return letters;
  }
}

List<WordDescription2> wordsList = [
  WordDescription2(
    word: "BAMBOO",
    description: "A fast-growing plant, often used in Asian architecture and crafts.",
  ),
  WordDescription2(
    word: "PAGODA",
    description: "A multi-tiered tower common in East Asia, often associated with temples.",
  ),
  WordDescription2(
    word: "DRAGON",
    description: "A mythical creature symbolizing power and wisdom in Asia.",
  ),
  WordDescription2(
    word: "TAIKO",
    description: "Traditional Japanese drums used in festivals and ceremonies.",
  ),
  WordDescription2(
    word: "LOTUS",
    description: "A sacred flower in many Asian cultures, symbolizing purity.",
  ),
  WordDescription2(
    word: "DIMSUM",
    description: "A variety of bite-sized dishes popular in Chinese cuisine.",
  ),
  WordDescription2(
    word: "KUNGFU",
    description: "A traditional Chinese martial art emphasizing discipline and skill.",
  ),
  WordDescription2(
    word: "ZEN",
    description: "A school of Buddhism emphasizing meditation and mindfulness.",
  ),
  WordDescription2(
    word: "GINSENG",
    description: "A medicinal root widely used in Asian herbal medicine.",
  ),
  WordDescription2(
    word: "KIMCHI",
    description: "A spicy fermented vegetable dish, iconic in Korean cuisine.",
  ),
  WordDescription2(
    word: "NOODLES",
    description: "A staple food in many Asian cuisines, served in diverse styles.",
  ),
  WordDescription2(
    word: "CALLIGRAPHY",
    description: "The art of beautiful handwriting, highly valued in East Asia.",
  ),
  WordDescription2(
    word: "FAN",
    description: "A traditional handheld accessory, often decorated with art.",
  ),
  WordDescription2(
    word: "YINYANG",
    description: "A symbol representing balance and harmony in Chinese philosophy.",
  ),
  WordDescription2(
    word: "RICE",
    description: "A fundamental staple food in most Asian countries.",
  ),
  WordDescription2(
    word: "TEMPLE",
    description: "A place of worship and cultural significance in Asia.",
  ),
  WordDescription2(
    word: "PHO",
    description: "A Vietnamese soup dish made with noodles and broth.",
  ),
  WordDescription2(
    word: "SAMOSA",
    description: "A fried pastry with spiced filling, popular in South Asia.",
  ),
  WordDescription2(
    word: "SHRINE",
    description: "A sacred place for offering prayers and honoring spirits.",
  ),
  WordDescription2(
    word: "KABUKI",
    description: "A traditional Japanese theater art known for its dramatic performances.",
  ),
];
