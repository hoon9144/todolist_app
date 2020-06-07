class Board{
  final int bid;
  final int uid;
  final String title;
  final String subtitle;
  final DateTime inserttime;
  final DateTime updatetime;

  Board({this.bid,this.uid,this.title,this.subtitle,this.inserttime,this.updatetime});

  factory Board.FromJson(Map<String,dynamic> json){
    return Board(
      bid: json['bid'],
      uid: json['uid'],
      title: json['title'],
      subtitle: json['subtitle'],
      inserttime: json['inserttime'],
      updatetime: json['updatetime']
    );
  }

  Map<String , dynamic> ToJson() => {
    'bid':bid,
    'uid':uid,
    'title':title,
    'subtitle':subtitle,
    'inserttime':inserttime,
    'updatetime':updatetime
  };


}