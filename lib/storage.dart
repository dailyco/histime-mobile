import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_storage/firebase_storage.dart';

class UploadTaskListTile extends StatelessWidget {
  const UploadTaskListTile(
      {Key key, this.task, this.onDismissed, this.onDownload})
      : super(key: key);

  final StorageUploadTask task;
  final VoidCallback onDismissed;
  final VoidCallback onDownload;

  String get status {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        result = 'Complete';
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StorageTaskEvent>(
      stream: task.events,
      builder: (BuildContext context,
          AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
        print("dddd" + asyncSnapshot.hasData.toString());
        if (!asyncSnapshot.hasData)
          return Center(
            child: Text("파일이 존재하지 않습니다.\n\n아래 버튼을 통해 새로운 파일을 업로드해주세요.", textAlign: TextAlign.center, ),
          );
        else
          return Dismissible(
            key: Key(task.hashCode.toString()),
            onDismissed: (_) => onDismissed(),
            child: Container(
              margin:  EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(color: Color(0xFF9CBADF)),
              child: ListTile(
                title: Text('Upload Task #${task.hashCode}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//              subtitle: subtitle,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Offstage(
                      offstage: !task.isInProgress,
                      child: IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: () => task.pause(),
                      ),
                    ),
                    Offstage(
                      offstage: !task.isPaused,
                      child: IconButton(
                        icon: const Icon(Icons.file_upload),
                        onPressed: () => task.resume(),
                      ),
                    ),
                    Offstage(
                      offstage: task.isComplete,
                      child: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => task.cancel(),
                      ),
                    ),
                    Offstage(
                      offstage: !(task.isComplete && task.isSuccessful),
                      child: IconButton(
                        icon: const Icon(Icons.file_download, color: Colors.white),
                        onPressed: onDownload,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}

