import 'package:flutter/material.dart';
import 'package:welding_app/constants.dart';

class FinishedProjects extends StatefulWidget {
  const FinishedProjects({Key? key}) : super(key: key);

  @override
  State<FinishedProjects> createState() => _FinishedProjectsState();
}

class _FinishedProjectsState extends State<FinishedProjects> {
  
  var finished_projects = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Projects'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 36,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // FINISHED PROJECTS
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 250,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
