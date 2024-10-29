import 'package:flutter/material.dart';

class TaskSearchBar extends StatefulWidget {
  const TaskSearchBar({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  State<TaskSearchBar> createState() => _TaskSearchBarState();
}

class _TaskSearchBarState extends State<TaskSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        controller: _controller,
        leading: const Icon(Icons.search_rounded),
        hintText: 'Cerca',
        onChanged: widget.onChanged,
        trailing: [
          IconButton(
            onPressed: () {
              _controller.clear();
              widget.onChanged('');
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
