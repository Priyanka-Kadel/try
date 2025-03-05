// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gear_rental/features/splash/presentation/view_model/splash_cubit.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SplashCubit>().init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(156, 30, 55, 145),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 200,
//                   width: 200,
//                   child: Image.asset('assets/images/bbicon.png'),
//                 ),
//                 const Text(
//                   'GoGear - Camping/Trekking Gear Rental',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'version : 1.0.0',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: MediaQuery.of(context).size.width / 3,
//             child: const Text(
//               'Developed by: Priyanka Kadel',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gear_rental/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  'GoGear',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                const Text('version : 1.0.0')
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Developed by: Priyanka Kadel',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
