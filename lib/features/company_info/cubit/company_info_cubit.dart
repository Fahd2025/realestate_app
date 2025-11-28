import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/database/database.dart';
import '../repositories/company_info_repository.dart';

part 'company_info_state.dart';

class CompanyInfoCubit extends Cubit<CompanyInfoState> {
  final CompanyInfoRepository _repository;

  CompanyInfoCubit(this._repository) : super(CompanyInfoInitial());

  Future<void> loadCompanyInfo() async {
    emit(CompanyInfoLoading());
    try {
      final info = await _repository.getCompanyInfo();
      emit(CompanyInfoLoaded(info));
    } catch (e) {
      emit(CompanyInfoError(e.toString()));
    }
  }

  Future<void> saveCompanyInfo(CompanyInfoCompanion info) async {
    emit(CompanyInfoSaving());
    try {
      await _repository.saveCompanyInfo(info);
      final updatedInfo = await _repository.getCompanyInfo();
      emit(CompanyInfoSaveSuccess(updatedInfo!));
      emit(CompanyInfoLoaded(updatedInfo));
    } catch (e) {
      emit(CompanyInfoError(e.toString()));
    }
  }
}
