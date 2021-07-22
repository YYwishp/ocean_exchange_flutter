import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  final String title;

  MoneyPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return new _MoneyPageState();
  }
}

class _MoneyPageState extends State<MoneyPage> {
  int num = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('意见反馈'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('反馈内容'),
                  TextFormField(
                    //最多多少字
                    maxLength: 100,
                    // 行数
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      hintText: '请输入',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black26,
              height: 20,
              width: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('添加图片'),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black45)),
                      onPressed: () {
                        // selectAssets();

                        setState(() {
                          num++;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                );
              },
              childCount: num,
            ),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 4,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 20,
            //   childAspectRatio: 1,
            // ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisExtent: 100,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Icon(Icons.access_time);
                },
                itemCount: 15,
                scrollDirection: Axis.horizontal,
              ),
            )
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.black26,
              height: 20,
              width: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('反馈内容'),
                  TextFormField(
                    //最多多少字
                    maxLength: 100,
                    // 行数
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      hintText: '请输入',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
