import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';
import 'recovery_profile_repository.dart';
import 'sos_session_repository.dart';
import 'local_recovery_profile_repository.dart';
import 'local_sos_session_repository.dart';
import 'local_mood_journal_repository.dart';
import 'local_letters_vault_repository.dart';
import 'beta_feedback_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final recoveryProfileRepositoryProvider = Provider((ref) => RecoveryProfileRepository());

final sosSessionRepositoryProvider = Provider((ref) => SosSessionRepository());

final localRecoveryProfileRepositoryProvider = Provider((ref) => LocalRecoveryProfileRepository());

final localSosSessionRepositoryProvider = Provider((ref) => LocalSosSessionRepository());

final localMoodJournalRepositoryProvider = Provider((ref) => LocalMoodJournalRepository());

final localLettersVaultRepositoryProvider = Provider((ref) => LocalLettersVaultRepository());

final betaFeedbackRepositoryProvider = Provider((ref) => BetaFeedbackRepository());
