import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
String videoUrl="https://static.videezy.com/system/resources/previews/000/007/336/original/00036.mp4";
late VideoPlayerController _playerController;
late Future<void> _futureControl;
int duValue=0;
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _playerController= VideoPlayerController.network(videoUrl);
    _futureControl= _playerController.initialize();
    duValue= _playerController.value.duration.inSeconds;
    _playerController.setLooping(false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video player"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _futureControl,
              builder: (context,abc){
                if(abc.connectionState== ConnectionState.done)
                  return AspectRatio(
                    aspectRatio: _playerController.value.aspectRatio,
                    child: VideoPlayer(_playerController),
                  );
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      // duValue= _playerController.
                      // value.duration.inSeconds;
                      duValue=duValue-5;
                      _playerController.seekTo
                        (Duration(seconds: duValue));
                    });
                  },
                  child: Icon(Icons.arrow_back_ios)),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      // duValue= _playerController.
                      // value.duration.inSeconds;
                      duValue=duValue+5;
                      _playerController.seekTo
                        (Duration(seconds: duValue));
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios))
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _playerController.value.isPlaying?
            _playerController.pause():
            _playerController.play();
          });
        },
        child: _playerController.value.isPlaying?
        Icon(Icons.pause):Icon(Icons.play_arrow),
      ),
    );
  }
}
