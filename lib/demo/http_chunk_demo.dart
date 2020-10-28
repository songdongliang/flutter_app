import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HttpChunkRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HttpChunkState();

}

class _HttpChunkState extends State<HttpChunkRoute> {

  Dio dio = Dio();

  static const String url = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593413409766&di=76b823b8b23951719728f9887700c079&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg";

  static String savePath = "/example/tupian.jpg";

  int progress = 0;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      savePath = dir.path + savePath;
//      Directory(savePath).deleteSync(recursive: true);
      File(savePath).create(recursive: true).then((value) {
        print(savePath);
        downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = (received / total * 100).floor();
              print("$progress%");
            });
          }
        });
      });
    });

  }

  Future<Response> downloadWithChunks(url,
      savePath, {
        ProgressCallback onReceiveProgress,
      }) async {

    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;

    var progress = <int>[];

    createCallback(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      end--;
      progress.add(0);
      return dio.download(
            url,
            savePath + "temp$no",
            onReceiveProgress: createCallback(no),
            options: Options(
              headers: {"Range": "bytes=$start-$end"}
            ));
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    print("statusCode: ${response.statusCode}");
    if (response.statusCode == 206) { // 分块请求成功，是206
      print(response.headers);
      total = int.parse(response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
      int reserved = total - int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await f.rename(savePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chunk download"),
      ),
      body: Center(
        child: progress == 100 ? Image.file(File(savePath))
            : CircularProgressIndicator(value: progress.toDouble()/100, valueColor: AlwaysStoppedAnimation(Colors.red)),
      ),
    );
  }

}