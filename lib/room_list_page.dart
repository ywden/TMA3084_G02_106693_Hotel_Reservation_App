import 'package:flutter/material.dart';
import 'room_type.dart';

class RoomListPage extends StatefulWidget{
  const RoomListPage({
    super.key,
    required this.preferred,
    required this.guests,
    required this.checkIn,
  });
  final RoomPreference preferred;
  final int guests;
  final String checkIn;

  @override
  State<RoomListPage> createState()=> _RoomListPageState();

}
class _RoomListPageState extends State<RoomListPage>{
  late final List<RoomType> _rooms;
  @override
  void initState(){
    super.initState();
    _rooms=buildRooms(widget.preferred);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Room')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Padding(
              padding:const EdgeInsets.all(16) ,
              child: Text(
                'Check-in ${widget.checkIn} | ${widget.guests} guests',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() => _rooms[index].isExpanded = isExpanded);
              }, 
              children: _rooms.map<ExpansionPanel>((RoomType room) {
                return ExpansionPanel(
                  isExpanded: room.isExpanded,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(room.icon),
                      title: Text(room.name),
                    );
                  },
                  body : ListTile(title: Text(room.description)),
                );
              }).toList(),
            ),
        ],
      ),
    ),
    );
  }
}