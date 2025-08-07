import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/models/branch/branch_response.dart';

part 'branch_state.freezed.dart';

@freezed
class BranchState with _$BranchState {
  const factory BranchState.initial() = Initial;
  const factory BranchState.loading() = Loading;
  const factory BranchState.loaded(BranchResponse branches) = Loaded;
  const factory BranchState.selected(BranchResponse branches, Branch selectedBranch) = Selected;
  const factory BranchState.error(String message) = Error;
} 