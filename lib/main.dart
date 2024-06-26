import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborly_flutter_app/core/routes/routes.dart';
import 'package:neighborly_flutter_app/core/utils/shared_preference.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/fogot_password_bloc/forgot_password_bloc.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/google_authentication_bloc/google_authentication_bloc.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/login_with_email_bloc/login_with_email_bloc.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/register_with_email_bloc/register_with_email_bloc.dart';
import 'package:neighborly_flutter_app/features/authentication/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:neighborly_flutter_app/features/homePage/bloc/update_location_bloc/update_location_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/add_comment_bloc/add_comment_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/feedback_bloc/feedback_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/fetch_comment_reply_bloc/fetch_comment_reply_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/get_all_posts_bloc/get_all_posts_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/get_comments_by_postId_bloc/get_comments_by_postId_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/get_post_by_id_bloc/get_post_by_id_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/give_award_bloc/give_award_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/report_post_bloc/report_post_bloc.dart';
import 'package:neighborly_flutter_app/features/posts/presentation/bloc/vote_poll_bloc/vote_poll_bloc.dart';
import 'package:neighborly_flutter_app/features/profile/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:neighborly_flutter_app/features/profile/presentation/bloc/get_user_info_bloc/get_user_info_bloc.dart';
import 'package:neighborly_flutter_app/features/upload/presentation/bloc/upload_file_bloc/upload_file_bloc.dart';
import 'package:neighborly_flutter_app/features/upload/presentation/bloc/upload_poll_bloc/upload_poll_bloc.dart';
import 'package:neighborly_flutter_app/features/upload/presentation/bloc/upload_post_bloc/upload_post_bloc.dart';
import 'dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await ShardPrefHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RegisterWithEmailBloc>(
            create: (context) => di.sl<RegisterWithEmailBloc>(),
          ),
          BlocProvider<LoginWithEmailBloc>(
            create: (context) => di.sl<LoginWithEmailBloc>(),
          ),
          BlocProvider<ResendOtpBloc>(
            create: (context) => di.sl<ResendOtpBloc>(),
          ),
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => di.sl<ForgotPasswordBloc>(),
          ),
          BlocProvider<OtpBloc>(
            create: (context) => di.sl<OtpBloc>(),
          ),
          BlocProvider<GoogleAuthenticationBloc>(
            create: (context) => di.sl<GoogleAuthenticationBloc>(),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => di.sl<ChangePasswordBloc>(),
          ),
          BlocProvider<GetAllPostsBloc>(
            create: (context) => di.sl<GetAllPostsBloc>(),
          ),
          BlocProvider<UploadPostBloc>(
            create: (context) => di.sl<UploadPostBloc>(),
          ),
          BlocProvider<ReportPostBloc>(
            create: (context) => di.sl<ReportPostBloc>(),
          ),
          BlocProvider<UploadPollBloc>(
            create: (context) => di.sl<UploadPollBloc>(),
          ),
          BlocProvider<FeedbackBloc>(
            create: (context) => di.sl<FeedbackBloc>(),
          ),
          BlocProvider<GetPostByIdBloc>(
            create: (context) => di.sl<GetPostByIdBloc>(),
          ),
          BlocProvider<GetCommentsByPostIdBloc>(
            create: (context) => di.sl<GetCommentsByPostIdBloc>(),
          ),
          BlocProvider<UpdateLocationBloc>(
            create: (context) => di.sl<UpdateLocationBloc>(),
          ),
          BlocProvider<DeletePostBloc>(
            create: (context) => di.sl<DeletePostBloc>(),
          ),
          BlocProvider<UploadFileBloc>(
            create: (context) => di.sl<UploadFileBloc>(),
          ),
          BlocProvider<AddCommentBloc>(
            create: (context) => di.sl<AddCommentBloc>(),
          ),
          BlocProvider<VotePollBloc>(
            create: (context) => di.sl<VotePollBloc>(),
          ),
          BlocProvider<FetchCommentReplyBloc>(
            create: (context) => di.sl<FetchCommentReplyBloc>(),
          ),
          BlocProvider<GiveAwardBloc>(
            create: (context) => di.sl<GiveAwardBloc>(),
          ),
          BlocProvider<GetUserInfoBloc>(
            create: (context) => di.sl<GetUserInfoBloc>(),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'Roboto',
          ),
          debugShowCheckedModeBanner: false,
          title: 'Neighborly',
          routerConfig: router,
        ));
  }
}
