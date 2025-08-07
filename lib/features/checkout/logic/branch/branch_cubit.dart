import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/models/branch/branch_response.dart';
import 'package:pharmacy/features/checkout/repository/branch_repository.dart';

import 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final BranchRepository _branchRepository;

  BranchCubit(this._branchRepository) : super(const BranchState.initial());

  Future<void> fetchBranches() async {
    emit(const BranchState.loading());
    
    final result = await _branchRepository.getBranches();
    
    result.when(
      success: (branches) {
        emit(BranchState.loaded(branches));
      },
      failure: (error) {
        emit(BranchState.error(error.message));
      },
    );
  }

  void selectBranch(Branch branch) {
    state.when(
      initial: () {},
      loading: () {},
      loaded: (branches) {
        emit(BranchState.selected(branches, branch));
      },
      selected: (branches, selectedBranch) {
        emit(BranchState.selected(branches, branch));
      },
      error: (message) {},
    );
  }

  void clearSelection() {
    state.when(
      initial: () {},
      loading: () {},
      loaded: (branches) {},
      selected: (branches, selectedBranch) {
        emit(BranchState.loaded(branches));
      },
      error: (message) {},
    );
  }
} 