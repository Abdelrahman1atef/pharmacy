part of 'branch_cubit.dart';

abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchLoaded extends BranchState {
  final BranchResponse branches;
  
  BranchLoaded(this.branches);
}

class BranchSelected extends BranchState {
  final BranchResponse branches;
  final Branch selectedBranch;
  
  BranchSelected(this.branches, this.selectedBranch);
}

class BranchError extends BranchState {
  final String message;
  
  BranchError(this.message);
} 