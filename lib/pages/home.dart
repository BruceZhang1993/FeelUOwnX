part of pages;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
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
                  borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  gapPadding: 1.0,
                ),
              ),
              autofocus: false,
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
                      title: Text(
                        searchedSongs[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subTitle: Text(
                        searchedSongs[index].artist,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      icon: Icon(Icons.music_note),
                    ),
                    onTap: () async {
                      models.SongDetail detail =  await FuoRunner.getSongDetail(context, searchedSongs[index]);
                      if (detail == null || detail.uri == null || detail.uri.isEmpty) {
                        showSnackBar(context, 'Cannot fetch song uri.');
                        return;
                      }
                      PlaybackService.startPlay(detail.uri).catchError(() => showSnackBar(context, 'Something wrong.'));
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
