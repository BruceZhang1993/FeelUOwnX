part of pages;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<models.Song> searchedSongs = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              autofocus: true,
              style: Theme.of(context).textTheme.bodyText1,
              onSubmitted: (String value) {
                searchSongs(context, value.trim());
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedSongs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: GestureDetector(
                    child: GFListTile(
                      titleText: searchedSongs[index].title,
                      subtitleText: searchedSongs[index].artist,
                      icon: Icon(Icons.music_note),
                    ),
                    onTap: () {
                      showSnackBar(context,
                        'Title: ${searchedSongs[index].title} Artist: ${searchedSongs[index].artist} FuoUri: ${searchedSongs[index].fuoUri}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  searchSongs(BuildContext context, String query) async {
    List<models.Song> songs = await FuoRunner.searchSongs(context, query);
    setState(() {
      searchedSongs = songs;
    });
  }
}
