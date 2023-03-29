// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ResetPasswordPage extends StatefulWidget {
//   const ResetPasswordPage({Key? key}) : super(key: key);
//
//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }
//
// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ResetPasswordBloc(),
//       child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
//         listener: (context, state) {
//           if (state.status == FormzStatus.submissionFailure) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(content: Text(state.errorMessage)),
//               );
//           }
//           if (state.status == FormzStatus.submissionSuccess) {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Success'),
//                 content: Text('Your Password has been reset to Foxconn168!!'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Confirm'),
//                   )
//                 ],
//               ),
//             ).whenComplete(() => Navigator.of(context).pop());
//           }
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             title: Text('Reset password'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _UsernameInput(),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 _CitizenCodeInput(),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 _SubmitButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _UsernameInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
//       buildWhen: (previous, current) => previous.username != current.username,
//       builder: (context, state) {
//         return TextField(
//           onChanged: (username) =>
//               context.read<ResetPasswordBloc>().add(UsernameChanged(username)),
//           decoration: InputDecoration(
//             labelText: 'ID Card',
//             errorText: state.username.invalid ? 'invalid username' : null,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _CitizenCodeInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
//       buildWhen: (previous, current) =>
//           previous.citizenCode != current.citizenCode,
//       builder: (context, state) {
//         return TextField(
//           onChanged: (citizenCode) => context
//               .read<ResetPasswordBloc>()
//               .add(CitizenCodeChanged(citizenCode)),
//           decoration: InputDecoration(
//             labelText: 'Citizen code',
//             errorText:
//                 state.citizenCode.invalid ? 'invalid citizen code' : null,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _SubmitButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const CircularProgressIndicator()
//             : MaterialButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 color: HexColor.fromHex('154F8E'),
//                 disabledColor: HexColor.fromHex('154F8E').withOpacity(.5),
//                 elevation: 8.0,
//                 clipBehavior: Clip.antiAlias,
//                 minWidth: double.infinity,
//                 child: Text(
//                   'Reset password',
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18),
//                 ),
//                 onPressed: state.status.isValidated
//                     ? () {
//                         context
//                             .read<ResetPasswordBloc>()
//                             .add(const ResetPasswordSubmitted());
//                       }
//                     : null,
//               );
//       },
//     );
//   }
// }
