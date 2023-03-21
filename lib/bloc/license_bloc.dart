import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/repository/license_repository.dart';
// import 'package:logos/src/presenter/views/perchase/bloc/product_bloc.dart';

//==============================================================================
// Bloc
//==============================================================================
class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final LicenseRepository _licenseRepository;
  LicenseBloc(
    this._licenseRepository,
  ) : super(const LicenseState(false)) {
    on<BuyLicenseEvent>((event, emit) async {
      bool result = await _licenseRepository.buyLicense();
      emit(LicenseState(result));
    });
  }
}

//==============================================================================
// Event
//==============================================================================
abstract class LicenseEvent extends Equatable {}

class BuyLicenseEvent extends LicenseEvent {
  @override
  List<Object?> get props => [];
}

//==============================================================================
// State
//==============================================================================
class LicenseState extends Equatable {
  final bool hasLicense;
  const LicenseState(this.hasLicense);
  @override
  List<Object?> get props => [hasLicense];
}

//==============================================================================
// Dependency 
//==============================================================================
// class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
//   final LicenseRepository _licenseRepository;
//   final ProductBloc _productBloc; // use Bloc
//   LicenseBloc(
//     this._licenseRepository,
//     // this._productBloc,
//   ) : super(const LicenseState(false)) {
//     on<BuyLicenseEvent>((event, emit) async {
//       bool result = await _licenseRepository.buyLicense();
//       emit(LicenseState(result));
//       // ProductBloc에게 알림
//       // _productBloc.add(PayLoadProductEvent(result));
//     });
//   }
// }
