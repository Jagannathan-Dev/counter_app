import 'package:counter_app/services/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// State provider for the counter
// final countProvider = StateProvider<int>((ref) => 0);

class Counter extends ConsumerWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Counter value
          Center(
            child: Text(
              '$count',
              style: GoogleFonts.montserrat(
                fontSize: MediaQuery.of(context).size.width - 200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonGradient(
                'Decrement',
                const [Color(0xff66023C), Color(0xffcd1c18)],
                () {
                  if (count > 0) {
                    ref.read(countProvider.notifier).decrement();
                  }
                },
              ),
              ButtonGradient(
                'Reset',
                const [Color(0xffb05f03), Color(0xfff4a460)],
                () {
                  ref.read(countProvider.notifier).reset();
                },
              ),
              ButtonGradient(
                'Increment',
                const [Color(0xff013220), Color(0xff1bb300)],
                () {
                  ref.read(countProvider.notifier).increment();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Gradient button widget
Widget ButtonGradient(
  String label,
  List<Color> colors,
  VoidCallback onPressed,
) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(100),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  );
}
