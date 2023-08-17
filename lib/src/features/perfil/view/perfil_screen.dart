// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class PerfilScreen extends StatefulWidget {
//   const PerfilScreen({
//     super.key,
//     this.axis = Axis.horizontal,
//   });

//   final Axis axis;

//   @override
//   State<PerfilScreen> createState() => _PerfilScreenState();
// }

// class _PerfilScreenState extends State<PerfilScreen> {
//   Widget buildProfilePage() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(
//                           'assets/images/maquiagem.jpeg',
//                         ),
//                         fit: BoxFit.cover)),
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//               ),
//               Column(
//                 children: [
//                   Container(
//                     height: 250,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           child: Image.asset(
//                             'assets/images/default_profile.png',
//                             height: 150,
//                             width: 150,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Text(
//               'James Summer',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Center(
//             child: Text(
//               'Flutter Software Engineer',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium
//                   ?.copyWith(color: Colors.grey),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       '234',
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     Text(
//                       'Projetos',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelLarge
//                           ?.copyWith(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '523',
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     Text(
//                       'Seguidores',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelLarge
//                           ?.copyWith(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '1213',
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     Text(
//                       'Seguindo',
//                       style: Theme.of(context)
//                           .textTheme
//                           .labelLarge
//                           ?.copyWith(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   child: Text('Sobre mim',
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleLarge
//                           ?.copyWith(fontWeight: FontWeight.bold)),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                       'Sou um influencer de tecnologia procurando empresas que precisam de divulgação, tenho muitos anos de experiencia e já passei pela maioriadas situações recorrentes da construção de um software, pode chamar que sou a pessoa certa para seu negócio'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: buildProfilePage(),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/default_profile.png'),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
