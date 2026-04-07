import 'package:flutter/material.dart';
import '../widgets/in_progress_read_card.dart';



class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView( 
    child: Padding(
      padding: const EdgeInsets.all(10.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.start,  
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const SizedBox(
                  width: 320,
                  height: 280,
                  child: InProgressReadCard(),
                ),
                const SizedBox(height: 10), 
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }

}