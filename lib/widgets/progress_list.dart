import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../models/trackers.dart';

class ProgressList extends StatelessWidget {
  final List<Progress> data;
  final VoidCallback showProgressAdd;
  final Function deleteData;
  const ProgressList(
      {Key? key,
      required this.data,
      required this.showProgressAdd,
      required this.deleteData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Progress",
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                    onPressed: showProgressAdd, icon: const Icon(Icons.add))
              ],
            ),
            const Divider(
              color: Color(0xFF605F5E),
            ),
            data.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text("No progress recorded yet..."),
                        Icon(
                          Icons.question_mark,
                          size: 60,
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(data[index].data.toString()),
                          subtitle: Text(Jiffy(data[index].date)
                              .format("MMMM do yyyy, h:mm a")),
                          trailing: IconButton(
                            onPressed: () {
                              deleteData(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }),
                      itemCount: data.length,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
