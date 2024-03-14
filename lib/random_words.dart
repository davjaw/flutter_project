import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// export "../random_words.dart";

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};
  void _pushSaved () {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext build) {
        final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asCamelCase,
                  style: _biggerFont,
                ),
              );
            },
        );
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Saved suggestions"),
            backgroundColor: Theme.of(context).primaryColor
          ),
          body: ListView(children: divided),
        );
      })
    );
  }
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title:Text("Startup Name Generator"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return  ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        /*2*/

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      });
  }
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style:_biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.add_box_rounded : Icons.add_box_outlined,
        color: alreadySaved ? Colors.amber : null,
      ),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }
}