import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/models/branch/branch_response.dart';
import 'package:pharmacy/features/checkout/repository/branch_repository.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchRepository _branchRepository;

  BranchCubit(this._branchRepository) : super(BranchInitial());

  Future<void> fetchBranches() async {
    emit(BranchLoading());
    
    final result = await _branchRepository.getBranches();
    
    result.when(
      success: (branches) {
        emit(BranchLoaded(branches));
      },
      failure: (error) {
        emit(BranchError(error.message));
      },
    );
  }

  void selectBranch(Branch branch) {
    if (state is BranchLoaded) {
      final currentState = state as BranchLoaded;
      emit(BranchSelected(currentState.branches, branch));
    }
  }

  void clearSelection() {
    if (state is BranchSelected) {
      final currentState = state as BranchSelected;
      emit(BranchLoaded(currentState.branches));
    }
  }
} 