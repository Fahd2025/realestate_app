part of 'company_info_cubit.dart';

abstract class CompanyInfoState {}

class CompanyInfoInitial extends CompanyInfoState {}

class CompanyInfoLoading extends CompanyInfoState {}

class CompanyInfoLoaded extends CompanyInfoState {
  final CompanyInfoData? info;
  CompanyInfoLoaded(this.info);
}

class CompanyInfoSaving extends CompanyInfoState {}

class CompanyInfoSaveSuccess extends CompanyInfoState {
  final CompanyInfoData info;
  CompanyInfoSaveSuccess(this.info);
}

class CompanyInfoError extends CompanyInfoState {
  final String message;
  CompanyInfoError(this.message);
}
