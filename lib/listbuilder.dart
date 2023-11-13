import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Listbuilder extends StatefulWidget {
  List temp;
  Map? logo;
  String? sort_condition;
  Listbuilder({required this.temp, this.sort_condition, this.logo});

  @override
  State<Listbuilder> createState() => _ListbuilderState();
}

class _ListbuilderState extends State<Listbuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.temp.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            height: 160,
            child: Column(
              children: [
                Container(
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  decoration: BoxDecoration(
                      color: widget.temp[index]['quote']['USD']
                                  ['percent_change_24h'] >
                              0
                          ? Color.fromARGB(255, 206, 249, 218)
                          : Color.fromARGB(255, 255, 207, 207),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: Image(
                            image: NetworkImage(
                                widget.logo![widget.temp[index]['id']])),
                      ),
                      title: Row(children: [
                        Text(
                          widget.temp[index]['symbol'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ]),
                      subtitle: Text(
                        widget.temp[index]['name'],
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$ " +
                                widget.temp[index]['quote']['USD']['price']
                                    .toString() +
                                " USD",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${widget.temp[index]['quote']['USD']['percent_change_24h'] > 0 ? '+' : ''}'
                            '${widget.temp[index]['quote']['USD']['percent_change_24h'].toString()}%',
                            style: TextStyle(
                              color: widget.temp[index]['quote']['USD']
                                          ['percent_change_24h'] >
                                      0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 35,
                        width: 275,
                        child: Image(
                          image: AssetImage(widget.temp[index]['quote']['USD']
                                      ['percent_change_24h'] >
                                  0
                              ? 'assets/images/bigup.png'
                              : 'assets/images/down.png'),
                          fit: BoxFit.fill,
                        ))
                  ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Top Cryptocurrencies',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.sort_condition}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black45),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black38,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              child: Image(
                  image: NetworkImage(widget.logo![widget.temp[index]['id']])),
            ),
            title: Row(children: [
              Text(
                widget.temp[index]['symbol'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                width: 14,
              ),
              Container(
                  height: 25,
                  width: 35,
                  child: Image(
                      image: AssetImage(widget.temp[index]['quote']['USD']
                                  ['percent_change_24h'] >
                              0
                          ? 'assets/images/up.png'
                          : 'assets/images/down.png')))
            ]),
            subtitle: Text(
              widget.temp[index]['name'],
              style: TextStyle(fontSize: 12),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$ " +
                      widget.temp[index]['quote']['USD']['price'].toString() +
                      " USD",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.temp[index]['quote']['USD']['percent_change_24h'] > 0 ? '+' : ''}'
                  '${widget.temp[index]['quote']['USD']['percent_change_24h'].toString()}%',
                  style: TextStyle(
                    color: widget.temp[index]['quote']['USD']
                                ['percent_change_24h'] >
                            0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
